class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Хянах самбар"
    @page_dashboard_active = true
    @users = User.all
    @waiting_order = Order.where(status: 0).count
    @delivery_order = Order.where(status: 1).count
    @canceled_order = Order.where(status: 2).count
    @finished_order = Order.where(status: 3).count
    @products = Product.count
    @customers = Order.select('phone_number').group('phone_number').uniq.count
  end
end
