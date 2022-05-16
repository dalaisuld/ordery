class AddSysDateToSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :site_configs, :sys_date, :string, default: ""
    add_column :site_configs, :bill_count, :integer, default: 1
  end
end
