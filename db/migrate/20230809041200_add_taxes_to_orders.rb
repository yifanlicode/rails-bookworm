class AddTaxesToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :taxes, :decimal
  end
end
