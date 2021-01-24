class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Захиалгийн жагсаалт"
    @page_orders_active = true
  end

  def list
    order_by = "created_at desc"
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end

    orders = Order.all
    render json: { data: orders, itemsCount: orders.count}
  end
end
