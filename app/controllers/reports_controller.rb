class ReportsController < ApplicationController
  def index

    @reports = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).group('action_user_id').sum(:cargo_price)

    @page_report_active = true
    @cargo_today_total = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q', q: "%#{Time.now.strftime('%Y-%m-%d')}%").first
    @cargo_today_total_cash = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q and is_cash = :is_cash', q: "%#{Time.now.strftime('%Y-%m-%d')}%", is_cash: "1" ).first
    @cargo_today_total_transaction = OrderDetail.select('SUM(cargo_price) AS total').where('finish_date like :q and is_cash = :is_cash', q: "%#{Time.now.strftime('%Y-%m-%d')}%", is_cash: "0" ).first

    @cargo_today = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).sum(:cargo_price)
  end
end
