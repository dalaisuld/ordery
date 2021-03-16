class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @page_title = 'Хүргэлтийн жагсаалт'
    @page_delivery_active = true
    @orders = Order.joins('INNER JOIN order_details ON orders.id=order_details.order_id
                          INNER JOIN clients ON orders.phone_number=clients.phone_number
                          INNER JOIN products ON products.id=order_details.product_id')
    @orders = @orders.where('order_details.status=2').group('clients.phone_number, clients.address')
    @orders = @orders.select("clients.phone_number, clients.address, GROUP_CONCAT(distinct products.name separator ', ') as pr_name, GROUP_CONCAT(distinct order_details.id separator ',') as order_details, count(order_details.status)  as pr_count")
  end
end
