class Category < ApplicationRecord

  has_and_belongs_to_many :products

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
