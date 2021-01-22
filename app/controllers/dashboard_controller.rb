class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Хянах самбар"
    @page_dashboard_active = true
    @users = User.all
  end
end
