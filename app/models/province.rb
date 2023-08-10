# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "name", "pst", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["addresses"]
  end
end