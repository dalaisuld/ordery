class ItemsImportsController < ApplicationController
  def new
    @items_import = ItemsImport.new
  end

  def create
    @items_import = ItemsImport.new(params[:items_import])
    if @items_import.save!(current_user.id)
      flash[:notice] = 'Амжилттай upload хийлээ.'
      redirect_to orders_path
    else
      flash[:alert] = 'Амжилтгүй upload хийлээ.'
      render :new
    end
  end
end
