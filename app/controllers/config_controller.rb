class ConfigController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:update]
  # before_action :authenticate_user!
  def index
    @page_config_active = true
    @site_config = SiteConfig.first
  end

  def update
    @site_config = SiteConfig.first
    @site_config.delivery_status = params[:delivery_status]
    @site_config.delivery_text = params[:delivery_text]
    @site_config.delivery_description = params[:delivery_description]
    @site_config.save
    flash[:notice] = 'Амжилттай хадгаллаа'
    redirect_to config_path
  end
end
