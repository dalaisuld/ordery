class AddDeliveryDescriptionToSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :site_configs, :delivery_description, :string
  end
end
