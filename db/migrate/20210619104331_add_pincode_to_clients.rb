class AddPincodeToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :pincode, :string
  end
end
