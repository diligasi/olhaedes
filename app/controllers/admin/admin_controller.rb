class Admin::AdminController < ActionController::Base
  layout 'admin'

  before_action :authenticate_admin_user!

  alias_method :current_user, :current_admin_user

  def page
    @page = params[:page] || 1
  end

  def per_page
    @per_page = params[:per_page] || 25
  end
end
