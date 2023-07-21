require 'csv'

Product.destroy_all
Category.destroy_all

# Create a default email and password for ActiveAdmin
# AdminUser.create!(email: 'yifan@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Create 10 categories about Books
# 10.times do
#   Category.create(name: Faker::Book.genre)
# end 

csv_file = Rails.root.join('db/books.csv')

# Create a hash to store the category name and their corresponding id
category_map = {}

counter = 0
CSV.foreach(csv_file, headers: true, col_sep: ',', quote_char: nil) do |row|
  title = row['title']
  authors = row['authors']
  published_year = row['published_year']
  description = row['description']
  isbn = row['isbn10']
  isbn13 = row['isbn13']
  average_rating = row['average_rating']
  thumbnail = row['thumbnail']
  ratings_count = row['ratings_count']
  num_pages = row['num_pages']

  next if authors.blank? || isbn.blank? || isbn13.blank? || title.blank? || description.blank? || thumbnail.blank?
  next if published_year.to_i.zero? || average_rating.to_i.zero? || ratings_count.to_i.zero? || num_pages.to_i.zero?
  product_data = {
    title: title,
    authors: authors,
    description: description,
    isbn: isbn,
    isbn13: isbn13,
    average_rating: average_rating,
    published_year: published_year,
    thumbnail: thumbnail,
    ratings_count: ratings_count,
    num_pages: num_pages,
    price: row['price'] || 20,
    stock: row['stock'] || 100
  }

  product = Product.create!(product_data)
  counter += 1
  break if counter >= 1000

  # Extract the categories from the row
  categories = row['categories'].split(',')

  next if categories.blank?

  # Create the categories in the database
  categories.each do |category_name|
    category_name.strip!
    category = category_map[category_name] ||= Category.find_or_create_by(name: category_name)
    product.categories << category
  end

end

