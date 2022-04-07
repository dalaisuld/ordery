class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:reset_pin_code, :show]

  def index
    render :layout => "home"
  end

  def show
    if params[:phone_number].present? && params[:pin_code].present?
      @orders = Order.where(phone_number: params[:phone_number])
      @clients = Client.find_by(phone_number: params[:phone_number], pincode: params[:pin_code])
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
    od.delivery_date,
    od.price AS actual_price,
    od.cargo_price,
    od.status').where('o.phone_number = :q', q: "#{params[:phone_number]}").order('o.id')
      @total_sent = 0
      @products.each do |product|
        if product.status == IS_WILLING
          @total_sent = @total_sent + (product.cargo_price.to_i * product.quantity.to_i)
        end
      end
    else
      render layout: false
    end
    render layout: false
  end

  def set_delivery_client
    address = params[:address]
    phone_number = params[:phone_number]
    client = Client.find_by(phone_number: phone_number)
    if client.present?
      client.address = address
      client.save

      check_delivery = Delivery.find_by(phone_number: phone_number)
      if check_delivery.present?
        render json: { message: "Хүргэлт бүртгэгдсэн байна"}, status: 400
      else
        delivery = Delivery.new
        delivery.phone_number = phone_number
        delivery.address = address
        delivery.delivery_date = Time.now.strftime('%Y-%m-%d')
        delivery.user_id = client.id
        delivery.save
        flash[:alert] = 'Хүргэлтийн захиалга амжилттай үүсгэлээ'
      end
    end
    render json: { message: "success"}, status: 200
  end

  def reset
    render layout: false
  end

  def reset_pin_code
    phone_number = params[:phone_number]
    client = Client.find_by(phone_number: phone_number)
    if client.present?
      pincode = rand(1000..9999)
      client.update(pincode: pincode)
      ApplicationHelper.send_sms(phone_number, "Tanii pin code: #{pincode.to_s} http://big-mall.mn")
      render json: { message: 'success'}, status: 200
    else
      render json: { message: 'Бүртгэлгүй хэрэглэгч'}, status: 401
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
