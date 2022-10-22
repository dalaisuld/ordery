class ReportsController < ApplicationController
  def index
    @current_date = params[:date]
    if @current_date.present?
      puts 'date selected'
    else
      @current_date = Time.now.strftime('%Y-%m-%d')
    end
    @reports = OrderDetail.where(finish_date: @current_date).group('action_user_id').sum(:cargo_price)
    @cargo_today = OrderDetail.where(finish_date: @current_date).sum(:cargo_price)
    @sold_total = Sold.where(sold_date: @current_date).sum('price * quantity')
    sql = "select p.id, p.name, sum(od.quantity) from order_details as od inner join products as p on p.id = od.product_id where od.finish_date = '#{@current_date}' group by od.product_id;"
    @sold_products = ActiveRecord::Base.connection.execute(sql)


  end
end
