class CreateOrders < ActiveRecord::Migration[6.0]
    def change
      create_table :orders do |t|
        t.integer :product_id, null: false, default: 1
        t.string :phone_number, null: false, default: 1
        t.integer :account_number, null: false
        t.integer :amount, null: false
        t.string :transition_date, null: false
        t.integer :quantity, null: false
        t.integer :total_amount, null: false
        t.integer :user_id, null: false
        t.integer :is_upload, limit: 2
        t.string :address, limit: 255
        t.integer :status, limit: 8
        t.integer :is_delivery_to_home, limit: 2
        t.integer :cargo_price
        t.integer :taking_confirm
        t.timestamps null: false
      end
    end
end
