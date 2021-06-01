class ReportsController < ApplicationController
  def index
    @page_report_active = true
    @cargo_today_total = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q', q: "%#{Time.now.strftime('%Y-%m-%d')}%").first
    @cargo_today_total_cash = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q and is_cash = :is_cash', q: "%#{Time.now.strftime('%Y-%m-%d')}%", is_cash: "1" ).first
    @cargo_today_total_transaction = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q and is_cash = :is_cash', q: "%#{Time.now.strftime('%Y-%m-%d')}%", is_cash: "0" ).first

    @cargo_today = OrderDetail.select('SUM(cargo_price) AS total,
    SUM(CASE WHEN is_cash = 0 THEN cargo_price ELSE 0 END) AS cash,
    SUM(CASE WHEN is_cash = 1 THEN cargo_price ELSE 0 END) AS transfer').where('delivery_date like :q or finish_date like :q', q: "%#{Time.now.strftime('%Y-%m-%d')}%").first
  end
end
