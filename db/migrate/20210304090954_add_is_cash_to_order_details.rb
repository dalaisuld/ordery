class AddIsCashToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :is_cash, :boolean
  end
end
