class AddfinishDateToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :finish_datetime, :datetime
    add_column :orders, :cp_is_cash, :boolean, default: false
  end
end
