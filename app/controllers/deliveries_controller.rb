class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @page_title = 'Хүргэлтийн жагсаалт'
    @page_delivery_active = true
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
                     client_id: Client.find_by_phone_number(delivery.phone_number).id,
                     phone_number: delivery.phone_number,
                     address: delivery.address,
                     driver: delivery.driver,
                     delivery_date: delivery.delivery_date,
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

  def update
    delivery = Delivery.find(params[:id])
    delivery.update(driver: params[:driver])
    render json: { data: 'success'}
  end

  def destroy
    Delivery.find(params[:id]).destroy
    render json: {'SMG':'Success'}
  end
end
