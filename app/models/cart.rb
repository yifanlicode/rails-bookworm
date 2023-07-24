# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy 
  has_many :products, through: :cart_items

  
  def add_item(product)
    cart_item = cart_items.find_by(product: product)

    if cart_item
      cart_item.quantity += 1
    else
      cart_item = cart_items.build(product: product)
    end

    cart_item
  end
 

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "updated_at", "user_id"]
  end

end

 