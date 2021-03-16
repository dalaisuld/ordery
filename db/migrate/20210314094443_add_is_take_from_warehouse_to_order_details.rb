class AddIsTakeFromWarehouseToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :is_take_from_warehouse, :boolean
  end
end
