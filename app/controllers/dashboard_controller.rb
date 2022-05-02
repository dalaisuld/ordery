class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'Хянах самбар'
    @page_dashboard_active = true
    @users = User.all
    @waiting_order = OrderDetail.where(status: IS_WAITING).count
    @willing_order = OrderDetail.where(status: IS_WILLING).count
    @delivery_order = OrderDetail.where(status: IS_DELIVERY).count
    @finished_order = OrderDetail.where(status: IS_FINISH).count
    @canceled_order = OrderDetail.where(status: IS_CANCELED).count
    @products = Product.count
    @customers = Client.count

    # @reports = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).group('action_user_id').sum(:cargo_price)
    # @cargo_today = OrderDetail.where(finish_date: Time.now.strftime('%Y-%m-%d')).sum(:cargo_price)


    @current_date = params[:date]
    if @current_date.present?
      puts 'date selected'
    else
      @current_date = Time.now.strftime('%Y-%m-%d')
    end
    @reports = OrderDetail.where(finish_date: @current_date).group('action_user_id').sum(:cargo_price)
    @cargo_today = OrderDetail.where(finish_date: @current_date).sum(:cargo_price)
    @sold_total = Sold.where(sold_date: @current_date).sum(:price)

  end

  def smstest
    ApplicationHelper.send_sms('99429967', 'Hello World')
  end
end
