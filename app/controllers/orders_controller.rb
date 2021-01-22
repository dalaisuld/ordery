class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Захиалгийн жагсаалт"
    @page_orders_active = true
  end
end
