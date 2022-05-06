class AddDeliveryStatusToSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :site_configs, :delivery_status, :boolean, default: false
    add_column :site_configs, :delivery_text, :string, default: ''
  end
end
