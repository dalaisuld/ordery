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
      @ordered_products = Order.joins('AS o INNER JOIN order_details AS order_detail ON o.id = order_detail.order_id INNER JOIN products AS pr ON order_detail.product_id = pr.id')
                              .select('order_detail.product_id, pr.name, pr.price, pr.quantity')
                              .where('o.status = 0').group('order_detail.product_id')


  end
end
