class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :orders
  has_many :order_items, through: :orders
  has_many :carts
  has_many :cart_items, through: :carts
  has_many :products, through: :cart_items






  def self.ransackable_attributes(auth_object = nil)
  ["created_at", "default", "email", "encrypted_password", "false", "id", "is_admin", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
  # devise admin role
  # def admin?
  #   is_admin
  # end
end
