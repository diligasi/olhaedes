class Pwa::PwaController < ActionController::Base
  layout 'pwa'

  before_action :authenticate_user!

  def page
    @page = params[:page] || 1
  end

  def per_page
    @per_page = params[:per_page] || 25
  end
end
