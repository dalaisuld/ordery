class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'Захиалгийн жагсаалт'
    @page_orders_active = true
  end

  def list
    order_by = 'id desc'
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end
    order_count = Order.search_by(params).count
    orders = Order.joins('LEFT JOIN products ON products.id = orders.product_id').select('orders.*, products.name, products.price').page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    orders = orders.search_by(params)
    render json: { data: orders, itemsCount: order_count }
  end
end
