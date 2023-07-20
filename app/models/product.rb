class Product < ApplicationRecord

  has_and_belongs_to_many :categories

  # Validations
  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :isbn13, presence: true, uniqueness: true
  validates :published_year, presence: true

  # Use scopes to filter products by status
  scope :on_sale, -> { where(status: 'on_sale') }
  scope :new_arrivals, -> { where(status: 'new_arrivals') }
  scope :out_of_stock, -> { where(status: 'out_of_stock') }


  # has_many_attached :images do |attachable|
  #   attachable.variant :thumb, resize: "100x100"
  #   attachable.variant :medium, resize: "300x300"
  # end

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :medium, resize: "300x300"
  end
  

  def self.ransackable_attributes(auth_object = nil)
    ["authors", "average_rating", "created_at", "description", "id", "isbn", "isbn13", "num_pages", "price", "published_year", "ratings_count", "stock", "thumbnail", "title", "updated_at"]
  end

end
