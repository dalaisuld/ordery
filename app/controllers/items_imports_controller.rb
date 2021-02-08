class ItemsImportsController < ApplicationController
  def new
    @items_import = ItemsImport.new
  end

  def create
    @items_import = ItemsImport.new(params[:items_import])
    if @items_import.save(current_user.id)
      flash[:alert] = 'Амжилттай upload хийлээ.'
      redirect_to orders_path
    else
      flash[:error] = 'Амжилтгүй upload хийлээ.'
      render :new
    end
  end
end
