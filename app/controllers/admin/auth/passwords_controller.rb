module Admin::Auth
  class PasswordsController < Devise::PasswordsController
    layout 'admin_sign_in'

    protected

    def after_resetting_password_path_for(resource_name)
      set_user
      admin_root_path
    end

    private

    def set_user
      cookies[:user_id] = current_admin_user.id
    end
  end
end
