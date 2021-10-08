class ReportsController < ApplicationController
  def index
    @reports = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).group('action_user_id').sum(:cargo_price)
    @cargo_today = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).sum(:cargo_price)
  end
end
