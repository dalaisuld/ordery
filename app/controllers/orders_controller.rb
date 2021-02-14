class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show update]

  def index
    @page_title = 'Захиалгийн жагсаалт'
    @page_orders_active = true
    if Order.where(status: 0).present?
      @products = Order.joins('LEFT JOIN products ON products.id = orders.product_id').select('products.id, products.name').group('products.id, products.name')
      puts "======>>> #{@products.inspect}"
    else
      @products = nil
    end
  end

  def show
    @page_orders_active = true
  end

  def update
    if params[:update]
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to orders_path, notice: 'Захиалгийн мэдээлэл амжилттай өөрчлөгдлөө' }
        else
          format.html { render :show }
        end
      end
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
    orders = Order.where(product_id: params[:product], status: 0)
    begin
      orders.update_all(cargo_price: params[:payment])
      render json:{ message: 'амжиллтай хийлээ' }, status: 200
    rescue => e
      render json:{ message: 'амжиллгүй хийлээ' }, status: 422
    end
  end

  private
  def set_model
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:phone_number, :address, :status, :is_delivery_to_home, :taking_confirm)
  end

end
