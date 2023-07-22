class AddOnSaleToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :on_sale, :boolean, default: false
    add_column :products, :discount, :decimal, precision: 5, scale: 2, default: 0.2
  end
end
