class AddActionUserIdToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :action_user_id, :integer, default: nil
  end
end
