class AddRejectedToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :rejected, :integer, default: 0
  end
end
