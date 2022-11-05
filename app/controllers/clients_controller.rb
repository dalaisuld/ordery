class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show update print print_cancel print_delivery]

  def index
    @page_title = 'Хэрэглэгчийн жагсаалт'
    @page_clients_active = true
    @pin_user = Client.where.not(pincode: [nil, ""]).count
  end

  def show
    @page_clients_active = true
  end

  def print
    @count = 1
    site_config = SiteConfig.first
    if site_config.sys_date.to_s == Time.now.strftime('%Y-%m-%d').to_s
      @count = site_config.bill_count
      @count = @count + 1
      site_config.update(bill_count: @count)
    else
      site_config.update(sys_date: Time.now.strftime('%Y-%m-%d'), bill_count: 1)
    end
    @products_print = Order.joins('AS o
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
    od.status').where('o.phone_number = :q and od.id in (:ids)', q: @client.phone_number.strip.to_s, ids: params[:ids].split(",")).order('status')
    @total_cargo_price_print = OrderDetail.where(id: params[:ids].split(",")).sum('cargo_price * quantity')
    render layout: false
  end


  def print_cancel
    @count = 1
    site_config = SiteConfig.first
    if site_config.sys_date.to_s == Time.now.strftime('%Y-%m-%d').to_s
      @count = site_config.bill_count_cancel
      @count = @count + 1
      site_config.update(bill_count_cancel: @count)
    else
      site_config.update(sys_date: Time.now.strftime('%Y-%m-%d'), bill_count_cancel: 1)
    end
    @products_print = Order.joins('AS o
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
    od.status').where('o.phone_number = :q and od.id in (:ids)', q: @client.phone_number.strip.to_s, ids: params[:ids].split(",")).order('status')
    @total_cargo_price_print = OrderDetail.where(id: params[:ids].split(",")).sum('cargo_price * quantity')
    render layout: false
  end

  def print_delivery
    @count = 1
    site_config = SiteConfig.first
    if site_config.sys_date.to_s == Time.now.strftime('%Y-%m-%d').to_s
      @count = site_config.bill_count_delivery
      @count = @count + 1
      site_config.update(bill_count_delivery: @count)
    else
      site_config.update(sys_date: Time.now.strftime('%Y-%m-%d'), bill_count_delivery: 1)
    end
    @products_print = Order.joins('AS o
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
    od.status').where('o.phone_number = :q and od.id in (:ids)', q: @client.phone_number.strip.to_s, ids: params[:ids].split(",")).order('status')
    @total_cargo_price_print = OrderDetail.where(id: params[:ids].split(",")).sum('cargo_price * quantity')
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
    od.take_date,
    od.delivery_date,
    od.finish_date,
    od.price AS actual_price,
    od.cargo_price,
    od.status').where('o.phone_number = :q', q: @client.phone_number.strip.to_s).order('status')

    @total_cargo_price = 10

    # Нийт шилжүүлсэн мөнгөн дүн
    @total_sent_amount = 10
    @total_product_price = 10
    # @total_product_price = OrderDetail.where(order_id: params[:id]).sum('price * quantity')

  end

end
