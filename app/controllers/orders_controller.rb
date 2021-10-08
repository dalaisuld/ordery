class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show update]

  def index
    @page_title = 'Захиалгын жагсаалт'
    @page_orders_active = true
    @products = Product.all
  end

  def show
    @page_orders_active = true
  end

  def update
    if params[:update]
      respond_to do |format|
        if @order.update(order_params)
          if @order.phone_number.present?
            Client.create!(phone_number: @order.phone_number) if Client.where(phone_number: @order.phone_number).count == 0
            LogsHelper.create("Утасны дугаар update хийлээ ##{@order.phone_number}", current_user.id)
          end
          format.html { redirect_to orders_path, notice: 'Захиалгын мэдээлэл амжилттай өөрчлөгдлөө' }
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
    orders = Order.page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    orders = orders.search_by(params)
    render json: { data: orders, itemsCount: order_count }
  end

  def add_cargo
    orders = OrderDetail.where(product_id: params[:product])
    begin
      orders.update_all(cargo_price: params[:payment])
      LogsHelper.create("Каргоны үнэ орууллаа  ##{params[:product]}-#{params[:payment]}", current_user.id)
      render json:{ message: 'амжиллтай хийлээ' }, status: 200
    rescue => e
      render json:{ message: 'амжиллгүй хийлээ' }, status: 422
    end
  end

  # Хүргэлтэнд гаргах
  def set_delivery
    order_details_ids =params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        product.quantity = product.quantity - order_detail.quantity
        product.save
        order_detail.status = IS_DELIVERY
        order_detail.is_take_from_warehouse = false
        order_detail.delivery_date = Time.now.strftime('%Y-%m-%d')
        order_detail.is_cash = params[:cargo_is_cash]
        order_detail.finish_date = Time.now.strftime('%Y-%m-%d')
        order_detail.user_id = current_user.id
        order_detail.action_user_id = current_user.id
        order_detail.save
      end
    end
    LogsHelper.create("Бараа хүргэлтэнд гаргалаа ##{params[:orderDetailIDs]}", current_user.id)
    render json:{ message: 'амжиллтай хийлээ' }, status: 200
  end

  #Бараа хүлээлгэн өгөх
  def take_products
    order_details_ids = params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        product.quantity = product.quantity - order_detail.quantity
        product.save
        order_detail.status = IS_FINISH
        order_detail.is_take_from_warehouse = true
        order_detail.finish_date = Time.now.strftime('%Y-%m-%d')
        order_detail.is_cash = params[:cargo_is_cash]
        order_detail.take_date = Time.now
        order_detail.user_id = current_user.id
        order_detail.action_user_id = current_user.id
        order_detail.save
      end
    end
    LogsHelper.create("Бараа хүлээлгэж өгсөн ##{params[:orderDetailIDs]}", current_user.id)
    render json:{ message: 'амжиллтай' }, status: 200
  end

  #Бараа цуцлах
  def cancel_products
    order_details_ids = params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        product.save
        order_detail.status = IS_CANCELED
        order_detail.save
      end
    end
    LogsHelper.create("Бараа цуцалсан ##{params[:orderDetailIDs]}", current_user.id)
    render json:{ message: 'амжиллтай' }, status: 200
  end

  #Хүргэлтэнд гарсан бүх барааг дуусгах
  def complete_all_deliveries
    order_details_ids = params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        product.quantity = product.quantity - order_detail.quantity
        product.save
        order_detail.status = IS_FINISH
        order_detail.finish_date = Time.now.strftime('%Y-%m-%d')
        order_detail.save
      end
    end
    render json:{ message: 'амжиллтай' }, status: 200
  end



  def set_take_confirm
    order_details_ids =params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        order_detail.status = IS_FINISH
        order_detail.is_take_from_warehouse = false
        order_detail.delivery_date = Time.now.strftime('%Y-%m-%d')
        order_detail.save
      end
    end
    render json:{ message: 'амжиллтай хийлээ' }, status: 200
  end

  private
  def set_model
    @order = Order.find(params[:id])
    @products = Product.where(status: 1)
    @order_details = OrderDetail.where(order_id: params[:id])
    @total_cargo_price = OrderDetail.where(order_id: params[:id]).sum('cargo_price * quantity')
    @total_product_price = OrderDetail.where(order_id: params[:id]).sum('price * quantity')
  end

  def order_params
    params.require(:order).permit(:phone_number, :address, :status, :is_delivery_to_home, :taking_confirm)
  end

end
