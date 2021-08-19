class SmsLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'SMS LOG'
    @page_sms_active = true
  end

  def list
    order_by = 'created_at desc'
    sms_logs_count = SmsLog.count
    sms_logs = SmsLog.all.page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    render json: { data: sms_logs, itemsCount: sms_logs_count }
  end
end
