class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @page_title = 'Хүргэлтийн жагсаалт'
    @page_delivery_active = true
    # @orders = Order.joins('INNER JOIN order_details ON orders.id=order_details.order_id
    #                       INNER JOIN clients ON orders.phone_number=clients.phone_number
    #                       INNER JOIN products ON products.id=order_details.product_id')
    # @orders = @orders.where('order_details.status=2').group('clients.phone_number, clients.address')
    # @orders = @orders.select("clients.phone_number, clients.address, GROUP_CONCAT(distinct products.name separator ', ') as pr_name, GROUP_CONCAT(distinct order_details.id separator ',') as order_details, count(order_details.status)  as pr_count")
    @deliveries = Delivery.all
  end

  # def list
  #   order_by = 'id desc'
  #   if params[:sortField].present? && params[:sortOrder].present?
  #     order_by = "#{params[:sortField]} #{params[:sortOrder]} "
  #   end
  #   clients_count = Client.search_by(params).count
  #   clients = Client.search_by(params).page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
  #   render json: { data: clients, itemsCount: clients_count }
  # end

  def list
    order_by = 'id desc'
    if params[:filter][:sortField].present? && params[:filter][:sortOrder].present?
      order_by = "#{params[:filter][:sortField]} #{params[:filter][:sortOrder]} "
    end
    deliveries = Delivery.filter_day(params[:filter_day]).search_by(params).page(params[:filter][:pageIndex]).per(params[:filter][:pageSize]).order(order_by)
    deliveries_count = Delivery.filter_day(params[:filter_day]).search_by(params).count
    new_arr = []
    deliveries.each do |delivery|
      new_arr.push({
                     id:delivery.id,
                     phone_number: delivery.phone_number,
                     address: delivery.address,
                     delivery_date: delivery.delivery_date,
                     products: DeliveriesHelper.delviery_products(delivery.id),
                     cargo: 'price',
                     status: case delivery.status
                             when 0
                               '<span class="text-theme-6 block">Хүлээгдэж байгаа</span>'
                             when 1
                               '<span class="text-theme-12 block">Хүргэлтэнд бэлдсэн</span>'
                             when 2
                               '<span class="text-theme-1 block">Хүргэлтэнд гарсан</span>'
                             when 3
                               '<span class="text-theme-9 block">Хүргэгдсэн</span>'
                             when 4
                               '<span class="text-gray-700 dark:text-gray-600 block">Цуцалсан</span>'
                             else
                               ''
                             end
                   })
    end
    puts new_arr.inspect
    render json: {data: new_arr, itemsCount: deliveries_count}
  end
end
