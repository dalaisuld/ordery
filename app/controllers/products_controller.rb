class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = "Агуулхын бүртгэл"
    @page_products_active = true
  end

  def list
    product = Product.select("products.id, products.name, price, total_amount, quantity, unit, category_id, products.created_at").joins(:category).search_by(params).page(params[:pageIndex]).per(params[:pageSize]).order(created_at: :desc)
    product_count = Product.search_by(params).count
    render json: { data: product, itemsCount: product_count}
  end

  def create
    Product.create!({category_id: params[:category_id], user_id: current_user.id, 
    name: params[:name], price: params[:price], total_amount: params[:quantity].to_i * params[:price].to_i, quantity: params[:quantity], 
    unit: params[:unit]})
  end

  def update
    product = Product.find(params[:id])
    product.update({category_id: params[:category_id], user_id: current_user.id, 
    name: params[:name], price: params[:price], total_amount: params[:quantity].to_i * params[:price].to_i, quantity: params[:quantity], 
    unit: params[:unit]})
  end

  def destroy
    Product.find(params[:id]).destroy
  end
end
