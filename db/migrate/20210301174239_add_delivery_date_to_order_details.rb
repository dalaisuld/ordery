class AddDeliveryDateToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :delivery_date, :datetime
  end
end
