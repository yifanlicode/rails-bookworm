class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  def full_address 
    "#{full_name}, #{phone_number}, #{address_line_1}, #{address_line_2}, #{city}, #{province.name}, #{postal_code}"
  end
  def self.ransackable_attributes(auth_object = nil)
    ["address_line_1", "address_line_2", "city", "created_at", "full_name", "id", "phone_number", "postal_code", "province_id", "updated_at", "user_id"]
  end
end