class AddFullNameAndPhoneNumberToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :full_name, :string
    add_column :addresses, :phone_number, :string
  end
end
