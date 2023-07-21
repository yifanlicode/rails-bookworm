class Product < ApplicationRecord

  has_and_belongs_to_many :categories
  has_one_attached :image

  # Validations
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
