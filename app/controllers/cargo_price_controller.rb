class CargoPriceController < ApplicationController
  def index
    @page_cargo_price_active = true
    @products = Product.all
    @products = @products.where.not(cargo: [nil]).order('updated_at desc')
    if params[:q]
      @products = @products.where("name like ?", "%#{params[:q]}%")
    end
  end
end
