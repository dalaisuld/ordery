class AddPhoneToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :phone_number, :string
    add_column :clients, :address, :string
    add_column :clients, :is_delivery_to_home, :boolean
  end
end
