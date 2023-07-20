class RemoveDefaultAndFalseFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :default, :string
    remove_column :users, :false, :string
  end
end
