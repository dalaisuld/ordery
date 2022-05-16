class AddCancelBillToSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :site_configs, :bill_count_cancel, :integer, default: 1
  end
end
