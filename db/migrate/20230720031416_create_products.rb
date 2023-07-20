class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :authors
      t.decimal :average_rating
      t.string :isbn
      t.string :isbn13
      t.integer :published_year
      t.integer :num_pages
      t.integer :ratings_count
      t.integer :stock
      t.decimal :price
      t.string :thumbnail

      t.timestamps
    end
  end
end
