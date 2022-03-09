class HomeController < ApplicationController

  def handler
    if current_admin_user.present?
      redirect_to_role_home
    elsif current_user.present?
      # redirect_to controller: 'pwa/field_forms', action: 'index'
      render plain: 'pwa/field_forms'
    else
      # redirect_to controller: 'pwa/auth/sessions', action: 'new'
      render plain: 'pwa/auth/sessions'
    end
  end

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
