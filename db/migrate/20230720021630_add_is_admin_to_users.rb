class AddIsAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :default, :string
    add_column :users, :false, :string
  end
end
