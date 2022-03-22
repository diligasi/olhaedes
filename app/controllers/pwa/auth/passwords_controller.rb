module Pwa::Auth
  class PasswordsController < Devise::PasswordsController
    layout 'pwa_sign_in'

    protected

    def after_resetting_password_path_for(resource_name)
      set_user
      app_root_path
    end

    private

    def set_user
      cookies[:user_id] = current_user.id
    end
  end
end
