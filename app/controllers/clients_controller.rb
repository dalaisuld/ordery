class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show update print]

  def index
    @page_title = 'Хэрэглэгчийн жагсаалт'
    @page_clients_active = true
  end

  def show
    @page_clients_active = true
  end

  def print
    @page_clients_active = true
    @page_title = 'Хэрэглэгчийн жагсаалт'
    render layout: false
  end

  def change_address
    @client = Client.find(params[:id])
    @client.address = Client.find(params[:address])
    @client.save!
  end


  def list
    order_by = 'id desc'
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end
    clients_count = Client.search_by(params).count
    clients = Client.search_by(params).page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    render json: { data: clients, itemsCount: clients_count }
  end

  private
  def set_model
    @client = Client.find(params[:id])
    @orders = Order.where(phone_number: @client.phone_number)
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
    od.status').where('o.phone_number = :q', q: @client.phone_number.strip.to_s).order('status')

    @total_cargo_price = @products.sum('p.price * p.quantity')
    # @total_product_price = OrderDetail.where(order_id: params[:id]).sum('price * quantity')

  end

end
