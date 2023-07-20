# app/admin/products.rb

ActiveAdmin.register Product do
  # Set the default sort order
  permit_params :title, :description, :authors, :average_rating, 
                :isbn, :price, :published_year, :thumbnail, :stock,
                :num_pages, :ratings_count, :isbn13, :image, category_ids: []

  # Show columns in the admin index page
  index do
    selectable_column
    id_column
    column :title
    column :authors
    column :price
    # column :published_year
    column :stock
    column :categories do |product|
      product.categories.map(&:name).join(', ').html_safe
    end
    actions
  end



  # Edit and New form fields
  form do |f|
    f.inputs "Product Details" do
      f.input :title

      # Check if the product has image
      if f.object.image.attached?
        # Display the images that have been uploaded and allow to remove or upload again
        div style: "display: flex; justify-content: center;" do
          image_tag(f.object.image, style: "max-width: 300px; margin: 0 auto;")
        end
        f.input :image, as: :file, hint: "Upload a new image"
      else
        f.input :image, as: :file
      end

      f.input :authors
      f.input :price
      f.input :stock
      f.input :published_year
      f.input :average_rating
      
      f.input :thumbnail
      
 
      f.input :num_pages
      f.input :ratings_count
      f.input :isbn
      f.input :isbn13
      f.input :description

      f.input :categories, as: :check_boxes, collection: Category.all.map { |category| [category.name, category.id] }
    end
    f.actions
  end

 
   
  # Set up the product filters

  filter :on_sale, label: "On Sale"
  filter :new_arrivals, label: "New Arrivals"
  filter :out_of_stock, label: "Out of Stock"



end
