class AddFinishDateToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :finish_date, :date
  end
end
