class HistoriesController < ApplicationController
    before_action :authenticate_user!
  
    def index
        @histories = Order.by_histories(params[:search_keyword])
    end
end
  