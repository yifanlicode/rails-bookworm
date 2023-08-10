# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end