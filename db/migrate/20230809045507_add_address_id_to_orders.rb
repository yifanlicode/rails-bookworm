class AddAddressIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :address_id, :integer
    remove_column :orders, :taxes, :decimal
    add_foreign_key :orders, :addresses
  end
end
