class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :service_worker

  def handler
    if current_admin_user.present?
      redirect_to_role_home
    elsif current_user.present?
      redirect_to controller: 'pwa/field_forms', action: 'index'
    else
      redirect_to controller: 'pwa/auth/sessions', action: 'new'
    end
  end

  def manifest; end

  def service_worker; end

  private

  def redirect_to_role_home
    if current_admin_user.admin?
      redirect_to controller: 'admin/users', action: 'index'
    elsif current_admin_user.supervisor?
      redirect_to controller: 'admin/dashboard', action: 'index'
    else # for lab users
      redirect_to controller: 'admin/field_forms', action: 'index'
    end
  end
end
