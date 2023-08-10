class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :addresses 
  has_many :orders


  validates :email, presence: true, uniqueness: true
  

  after_create :create_cart

  private

  def create_cart
    Cart.create(user: self)
  end


  def self.ransackable_attributes(auth_object = nil)
  ["created_at", "default", "email", "encrypted_password", "false", "id", "is_admin", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["cart"]
  end

  # devise admin role
  # def admin?
  #   is_admin
  # end
end
