class ReportsController < ApplicationController
  def index
    @current_date = params[:date]
    if @current_date.present?
      puts 'date selected'
    else
      @current_date = Time.now.strftime('%Y-%m-%d')
    end
    @reports = OrderDetail.where(finish_date: @current_date).group('action_user_id').sum('cargo_price * quantity')
    @cargo_today = OrderDetail.where(finish_date: @current_date).sum('cargo_price * quantity')
    @sold_total = Sold.where(sold_date: @current_date).sum('price * quantity')
  end
end
