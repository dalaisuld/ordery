class CreateProducts < ActiveRecord::Migration[6.0]
    def change
      create_table :products do |t|
        t.integer :category_id, null: false, default: 1
        t.integer :user_id, null: false, default: 1
        t.string :name, null: false
        t.integer :price, null: false
        t.integer :total_amount, null: false
        t.integer :quantity, null: false
        t.integer :prev_quantity, null: false
        t.integer :unit, null: false, limit: 1
        t.timestamps null: false
      end
    end
  end
  