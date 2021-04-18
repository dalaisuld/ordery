class CreateDeliveryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_products do |t|
      t.integer :order_detail_id, null: false
      t.string :product_name, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :price, null: false
      t.integer :cargo_price, null: false, default: 0
      t.timestamps
    end
  end
end
