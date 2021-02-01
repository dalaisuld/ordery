class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :product_id, null: false, default: 1
      t.string :phone_number, null: true
      t.string :account_number, null: false
      t.integer :amount, null: false
      t.string :description, default: ''
      t.string :transition_date, null: true
      t.integer :quantity, null: false, default: 1
      t.integer :total_amount, null: false
      t.integer :user_id, null: false
      t.integer :is_upload, limit: 2, default: 0
      t.string :address, limit: 255
      t.integer :status, default: 0
      t.integer :cargo_price
      t.boolean :is_delivery_to_home
      t.boolean :taking_confirm
      t.timestamps null: false
    end
  end
end
