# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "created_at", "id", "status", "total_amount", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user"]
  end
end