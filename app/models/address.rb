class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  def full_address 
    "#{full_name}, #{phone_number}, #{address_line_1}, #{address_line_2}, #{city}, #{province.name}, #{postal_code}"
  end
end