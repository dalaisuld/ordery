class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer :order_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :price, null: false
      t.integer :cargo_price, null: false, default: 0
      t.timestamps
    end
  end
end
