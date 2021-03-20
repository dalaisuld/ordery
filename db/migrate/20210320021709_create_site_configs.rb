class CreateSiteConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :site_configs do |t|
      t.string :name, null: true
      t.string :title, null: true
      t.string :logo, null: true
      t.string :address, null: true
      t.string :phone_number, null: true
      t.string :facebook_name, null: true
      t.string :facebook_url, null: true
      t.string :instagram_name, null: true
      t.string :instagram_url, null: true
      t.string :lat, null: true
      t.string :long, null: true
      t.timestamps
    end
  end
end
