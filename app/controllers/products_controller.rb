class ProductsController < ApplicationController
    before_action :authenticate_user!

    def index
        product = Product.search_by(params)
        render json: product
    end

    def create
        Product.create!({category_id: params[:category_id], user_id: params[:user_id], 
        name: params[:name], price: params[:price], total_amount: params[:total_amount], quantity: params[:quantity], 
        prev_quantity: params[:prev_quantity], unit: params[:unit]})
    end

    def update
        Product.create!({category_id: params[:category_id], user_id: params[:user_id], 
        name: params[:name], price: params[:price], total_amount: params[:total_amount], quantity: params[:quantity], 
        prev_quantity: params[:prev_quantity], unit: params[:unit]})
    end

    def destroy
        Product.find(params[:id]).destroy
    end
end
