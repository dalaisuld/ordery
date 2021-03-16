class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_title = 'Агуулхын бүртгэл'
    @page_products_active = true
    @categoris = Category.order('id desc')
  end

  def list
    order_by = 'created_at desc'
    if params[:sortField].present? && params[:sortOrder].present?
      order_by = "#{params[:sortField]} #{params[:sortOrder]} "
    end
    product = Product.select('products.id, products.name, price, total_amount, quantity, unit, category_id, products.created_at').search_by(params)
                  .page(params[:pageIndex]).per(params[:pageSize]).order(order_by)
    products = Product.search_by(params)
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
    quantity =  params[:quantity]
    products = OrderDetail.where('status  IN (0,1) and product_id = :id', id: product.id)
    ordere_pr_count = products.select('sum(quantity) as total').first
    puts "neeedz ===>#{ordere_pr_count.total.to_s.to_i} "
    puts "quantity ===> #{quantity.to_s.to_i}"
    if quantity.to_s.to_i >= ordere_pr_count.total.to_s.to_i
      products.each do |product|
        product.status = IS_WILLING
        product.save
        puts '--------------->>>>'
      end
    else
      counter = 0
      products.each do |product|
        product.status = IS_WAITING
        product.save
      end
      products.each do |product|
        counter = counter + product.quantity.to_s.to_i
        product.status = IS_WILLING
        product.save
        puts "counter =====> #{counter}"
        break if counter.to_i >= quantity.to_s.to_i
      end
    end
    render json: { data: 'success'}
  end

  def destroy
    Product.find(params[:id]).destroy
  end
end
