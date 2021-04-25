class AddDeliveryIdToDeliveryProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_products, :delivery_id, :integer
  end
end
