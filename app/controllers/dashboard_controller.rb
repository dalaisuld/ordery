class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Хянах самбар"
    @page_dashboard_active = true
    @users = User.all
    @waiting_order = OrderDetail.where(status: IS_WAITING).count
    @willing_order = OrderDetail.where(status: IS_WILLING).count
    @delivery_order = OrderDetail.where(status: IS_DELIVERY).count
    @finished_order = OrderDetail.where(status: IS_FINISH).count
    @canceled_order = OrderDetail.where(status: IS_CANCELED).count
    @products = Product.count
    @customers = Client.count
    @ordered_products = OrderDetail.joins('as od inner join products as p on p.id = od.product_id')
                                      .select('p.id, p.name, p.price, p.quantity, count(od.status) as all_product,
                          SUM(case when od.status = 0 then 1 else 0 end) as is_waiting,
                          SUM(case when od.status = 1 then 1 else 0 end) as is_willing,
                          SUM(case when od.status = 2 then 1 else 0 end) as is_delivery,
                          SUM(case when od.status = 3 then 1 else 0 end) as is_finish,
                          SUM(case when od.status = 4 then 1 else 0 end) as is_cancelled')
                                      .group('p.id, p.name')

    @cargo_today = OrderDetail.select('SUM(cargo_price) AS total,
    SUM(CASE WHEN is_cash = 0 THEN cargo_price ELSE 0 END) AS cash,
    SUM(CASE WHEN is_cash = 1 THEN cargo_price ELSE 0 END) AS transfer').where('delivery_date = :q or finish_date = :q', q: "#{Time.now.strftime('%Y-%m-%d')}").group('cargo_price').order('cargo_price').first

    @cargo_yesterday = OrderDetail.select('SUM(cargo_price) AS total,
    SUM(CASE WHEN is_cash = 0 THEN cargo_price ELSE 0 END) AS cash,
    SUM(CASE WHEN is_cash = 1 THEN cargo_price ELSE 0 END) AS transfer').where('delivery_date = :q or finish_date = :q', q: "#{Date.today.prev_day.strftime('%Y-%m-%d')}").group('cargo_price').order('cargo_price').first

  end
end
