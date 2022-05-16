class AddDeliveryBillToSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :site_configs, :bill_count_delivery, :integer, default: 1
  end
end
