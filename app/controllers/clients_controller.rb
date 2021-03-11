class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show update]

  def index
    @page_title = "Хэрэглэгчийн жагсаалт"
    @page_clients_active = true
  end

  def show
    @page_clients_active = true
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
    client_count = Client.joins('As c left join orders as o on c.phone_number = o.phone_number left join order_details as od on od.order_id = o.id')
                       .select('c.id, c.phone_number, c.address, c.is_delivery_to_home, count(od.status) as all_product,
                                SUM(case when od.status = 0 then 1 else 0 end) as is_waiting,
                                SUM(case when od.status = 1 then 1 else 0 end) as is_willing,
                                SUM(case when od.status = 2 then 1 else 0 end) as is_delivery,
                                SUM(case when od.status = 3 then 1 else 0 end) as is_finish,
                                SUM(case when od.status = 4 then 1 else 0 end) as is_cancelled')
                       .group('c.id, c.phone_number, c.address, c.is_delivery_to_home').search_by(params).length

    clients = Client.joins('As c left join orders as o on c.phone_number = o.phone_number left join order_details as od on od.order_id = o.id')
                  .select('c.id, c.phone_number, c.address, c.is_delivery_to_home, count(od.status) as all_product,
                          SUM(case when od.status = 0 then 1 else 0 end) as is_waiting,
                          SUM(case when od.status = 1 then 1 else 0 end) as is_willing,
                          SUM(case when od.status = 2 then 1 else 0 end) as is_delivery,
                          SUM(case when od.status = 3 then 1 else 0 end) as is_finish,
                          SUM(case when od.status = 4 then 1 else 0 end) as is_cancelled')
                  .group('c.id, c.phone_number, c.address, c.is_delivery_to_home')
                  .page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    clients = clients.search_by(params)
    render json: { data: clients, itemsCount: client_count }
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
    od.status').where('o.phone_number = :q', q: "#{@client.phone_number.strip}").order('o.id')

    @delivered_product = Order.joins('AS o
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
    od.status').where('od.delivery_date = :q or od.finish_date', q: "#{Time.now.strftime('%Y-%m-%d')}").order('o.id')

    @total_cargo_price = Order.joins('AS o
        LEFT JOIN
    order_details AS od ON o.id = od.order_id
        LEFT JOIN
    products AS p ON od.product_id = p.id').where('od.delivery_date = :q or od.finish_date', q: "#{Time.now.strftime('%Y-%m-%d')}").sum('od.cargo_price')
  end

end
