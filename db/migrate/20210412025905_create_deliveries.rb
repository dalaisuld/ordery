class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :phone_number, null: false
      t.string :address, limit: 500
      t.datetime :delivery_date
      t.integer :status, default: 0
      t.integer :user_id, null: false
      t.string :memo, null: true, limit: 1000
      t.timestamps
    end
  end
end
