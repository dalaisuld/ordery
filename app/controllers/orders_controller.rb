class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Захиалгийн жагсаалт"
    @page_orders_active = true
  end

  def list
    order_by = "id desc"
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end

    orders = Order.all.page(params[:pageIndex]).per(params[:pageSize]).order(order_by)

    order_count = Order.search_by(params).count
    render json: { data: orders, itemsCount: order_count}
  end
end
