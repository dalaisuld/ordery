class AddDriverToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :driver, :string
  end
end
