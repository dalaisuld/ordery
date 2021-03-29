class ItemsImportsController < ApplicationController
  def new
    @items_import = ItemsImport.new
  end

  def create
    @items_import = ItemsImport.new(params[:items_import])
    response = @items_import.save(current_user.id)
    if response == true
      flash[:notice] = 'Амжилттай upload хийлээ.'
      redirect_to orders_path
    else
      flash[:alert] = response
      render :new
    end
  end
end
