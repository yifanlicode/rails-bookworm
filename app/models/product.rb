class Product < ApplicationRecord

  has_and_belongs_to_many :categories

  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
    attachable.variant :medium, resize_to_limit: [300, 300]
  end


  # Scopes (class methods)
  scope :on_sale, -> { where(on_sale: true) }
  scope :created_in_last_days, ->(days) { where('created_at > ?', days.days.ago) }
  scope :updated_in_last_days, ->(days) { where('updated_at > ?', days.days.ago) }

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :isbn13, presence: true, uniqueness: true
  validates :published_year, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["authors", "average_rating", "created_at", "description", "id", "isbn", "isbn13", "num_pages", "price", "published_year", "ratings_count", "stock", "thumbnail", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image"]
  end

end
