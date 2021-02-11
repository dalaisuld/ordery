class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'Захиалгийн жагсаалт'
    @page_orders_active = true
    if Order.where(status: 0).present?
      @orders = Product.select('products.name as name, orders.id as id').joins('INNER JOIN orders ON products.id=orders.product_id').group('products.name').where('orders.status = 0')
    else
      @orders = nil
    end
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

  def add_cargo
    orders = Order.where(product_id: params[:product])
    begin
      orders.update_all(status: 0, cargo_price: params[:payment])
      render json:{ message: 'амжиллтай хийлээ' }, status: 200
    rescue => e
      render json:{ message: 'амжиллгүй хийлээ' }, status: 422
    end
  end
end
