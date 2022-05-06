class ConfigController < ApplicationController
  before_action :authenticate_user!
  def index
    @page_config_active = true
    @site_config = SiteConfig.first
  end

  def update
    @site_config = SiteConfig.first
    if params[:delivery_status] and params[:delivery_text]
      @site_config.delivery_status = params[:delivery_status]
      @site_config.delivery_text = params[:delivery_text]
      @site_config.save
    end
  end
end
