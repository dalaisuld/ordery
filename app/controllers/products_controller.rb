class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'Агуулхын бүртгэл'
    @page_products_active = true
  end

  def list
    order_by = 'created_at desc'
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end
    product = Product.select('products.id, products.name, price, total_amount, quantity, unit, category_id, products.created_at').search_by(params)
    .page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    products = Product.search_by(params)
    puts "=======>>> Sum = #{product.sum(:total_amount)}"
    render json: { data: product, itemsCount: products.count, sum: products.sum(:total_amount)}
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
