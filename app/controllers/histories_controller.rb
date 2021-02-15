class HistoriesController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @history = Order.by_histories(params[:search_keyword])
    end
end
  