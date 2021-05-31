class AddUserIdToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :user_id, :integer, null: true
    add_column :order_details, :take_date, :datetime
  end
end
