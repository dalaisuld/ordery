class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @page_dashboard_active = true
    end
end