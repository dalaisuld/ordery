class AddOrderedCountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :ordered_count, :integer, default: 0
  end
end
