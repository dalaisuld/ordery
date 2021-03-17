class LogsController < ApplicationController
    def index    
        @page_title = 'Түүх'
        @page_logs_active = true
        @categoris = Category.order('id desc')
    end

    def create
        logs = Log.select("created_at, description, user_id, (select first_name from users where id = user_id) as username").
        search_by(params).page(params[:pageIndex]).per(params[:pageSize])
        logs_count = Log.all
        logs.each do |log|
            log['created_at'].strftime("%Y%M%d")
        end
        render json: { data: logs, itemsCount: logs_count}
    end
end