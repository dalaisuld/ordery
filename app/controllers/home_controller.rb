class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:reset_pin_code]

  def index
    render :layout => "home"
  end

  def show
    if params[:phone_number].present? && params[:pin_code].present?
      @orders = Order.where(phone_number: params[:phone_number])
      @clients = Client.find_by(phone_number: params[:phone_number],pincode: params[:pin_code])
      @deliveries = Delivery.where(phone_number: params[:phone_number])
      @products = Order.joins('AS o
        LEFT JOIN
    order_details AS od ON o.id = od.order_id
        LEFT JOIN
    products AS p ON od.product_id = p.id').select('o.id as order_id,
    od.id as order_detail_id,
    o.account_number,
    o.amount AS transition_amount,
    o.description,
    o.transition_date,
    p.name,
    p.price AS product_price,
    od.quantity,
    od.price AS actual_price,
    od.cargo_price,
    od.status').where('o.phone_number = :q', q: "#{params[:phone_number]}").order('o.id')
    else
      flash[:error] = 'Нууц үг эсвэл утасны дугаар буруу байна'
    end
    render layout: false
  end

  def set_delivery_client
    address = params[:address]
    phone_number = params[:phone_number]
    order_details_ids =params[:orderDetailIDs]
    order_details_ids.each do |order_detail_id|
      order_detail = OrderDetail.find_by(id: order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        order_detail.status = IS_DELIVERY
        order_detail.save!
        delivery = Delivery.new
        delivery.address = address
        delivery.phone_number = phone_number
        delivery.status = 0
        delivery.user_id = 1
        delivery.delivery_date = DateTime.now.strftime('%Y-%m-%d')
        delivery.save!
        delivery_product = DeliveryProduct.new
        delivery_product.delivery_id = delivery.id
        delivery_product.order_detail_id = order_detail_id
        delivery_product.product_name = product.name
        delivery_product.quantity = product.quantity
        delivery_product.price = product.price
        delivery_product.cargo_price = order_detail.cargo_price
        delivery_product.save!
      end
    end
  end

  def reset
    render layout: false
  end

  def reset_pin_code
    begin
      phone_number = params[:phone_number]
      client = Client.find_by(phone_number: phone_number)
      if client.present?
        pincode = rand(1000..9999)
        client.update(pincode: pincode)
        puts
        ApplicationHelper.send_sms(phone_number, "Tanii pin code: #{pincode.to_s} bigmall.mn")
        render json: { message: 'success'}, status: 200
      else
        render json: { message: 'Бүртгэлгүй хэрэглэгч'}, status: 401
      end
    rescue StandardError => e
      puts "#{e.to_s}"
      render json: { message: 'error'}, status: 400
    end
  end


  def update
    begin
      clients = Client.find_by(phone_number: params[:phone_number])
      clients.update(is_delivery_to_home: params[:is_delivery_to_home], address: params[:address])
      render json: { message: "success"}, status: 200
    rescue
      render json: { message: "error"}, status: 400
    end
  end
end
