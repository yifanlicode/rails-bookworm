require 'csv'

Product.destroy_all
Category.destroy_all

# Create a default email and password for ActiveAdmin
# AdminUser.create!(email: 'yifan@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Create 10 categories about Books
10.times do
  Category.create(name: Faker::Book.genre)
end 

# 读取CSV文件
csv_file = Rails.root.join('db/books.csv')

# 使用CSV.foreach并设置引号为nil
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

  next if authors.blank? || isbn.blank? || isbn13.blank? || title.blank? || description.blank? || average_rating.blank?  || published_year.blank? || thumbnail.blank? || ratings_count.blank? || num_pages.blank?

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


  # add categories to product randomly
  categories = Category.order('RANDOM()').limit(2)
  product.categories << categories

  counter += 1
  break if counter >= 1000

end

