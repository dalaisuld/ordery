class AddStatusToOrderDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :status, :integer
  end
end
