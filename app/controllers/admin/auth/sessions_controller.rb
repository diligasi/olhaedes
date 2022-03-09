module Admin::Auth
  class SessionsController < Devise::SessionsController
    layout 'admin_sign_in'

    def create
      self.resource = warden.authenticate!(auth_options)

      if !self.resource.field?
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        sign_out
        set_flash_message!(:alert, :access_denied)
        redirect_to new_admin_user_session_path
      end
    end

    def after_sign_in_path_for(resource)
      stored_location_for(resource) || admin_root_path
    end

    def after_sign_out_path_for(_)
      new_admin_user_session_path
    end
  end
end
