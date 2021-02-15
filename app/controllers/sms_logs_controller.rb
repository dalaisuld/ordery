class SmsLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'SMS LOG'
    @page_sms_active = true
  end

  def list
    order_by = 'created_at desc'
    sms_logs = SmsLog.search_by(params).page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    render json: { data: sms_logs, itemsCount: sms_logs.count }
  end
end
