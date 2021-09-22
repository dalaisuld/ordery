class AddCargoToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :cargo, :integer
  end
end
