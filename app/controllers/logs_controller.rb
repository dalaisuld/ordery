class LogsController < ApplicationController
    def index    
        @page_title = 'Түүх'
        @page_logs_active = true
        @categoris = Category.order('id desc')
        @logs = Log.all
    end
end