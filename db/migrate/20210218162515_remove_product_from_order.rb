class RemoveProductFromOrder < ActiveRecord::Migration[6.0]
  def change
    if ActiveRecord::Base.connection.column_exists?(:orders, :product_id)
      remove_column :orders, :product_id, :integer, if_exists: true
    end
    if ActiveRecord::Base.connection.column_exists?(:orders, :quantity)
      remove_column :orders, :quantity, :integer, if_exists: true
    end
    if ActiveRecord::Base.connection.column_exists?(:orders, :total_amount)
      remove_column :orders, :total_amount, :integer, if_exists: true
    end
  end
end
