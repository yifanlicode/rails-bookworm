# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy 


  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)

    if current_item 
      current_item.increment(:quantity)
    else
      current_item = cart_items.build(product_id: product.id)
    end
    current_item
  end



  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "updated_at", "user_id"]
  end

end

 