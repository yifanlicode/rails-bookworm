class UpdateOrdersWithAddressAndTaxes < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :address_id, :integer
    add_column :orders, :address, :text
    add_column :orders, :taxes, :decimal, precision: 10, scale: 2
  end
end
