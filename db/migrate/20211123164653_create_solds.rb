class CreateSolds < ActiveRecord::Migration[6.0]
  def change
    create_table :solds do |t|
      t.integer :product_id, null: false
      t.string :product_name, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :price, null: false
      t.integer :action_user_id, default: nil
      t.datetime :sold_date, default: nil
      t.timestamps
    end
  end
end
