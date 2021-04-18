class HomeController < ApplicationController
  def index
    render :layout => "home"
  end

  def show
    @orders = Order.where(phone_number: params[:phone_number])
    @clients = Client.find_by(phone_number: params[:phone_number])
    @deliveries = Delivery.where(phone_number: params[:phone_number])
    @products = Order.joins('AS o
        LEFT JOIN
    order_details AS od ON o.id = od.order_id
        LEFT JOIN
    products AS p ON od.product_id = p.id').select('o.id as order_id,
    od.id as product_id,
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
    render :layout => false
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
