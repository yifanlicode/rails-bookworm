# app/admin/products.rb

ActiveAdmin.register Product do


  permit_params :title, :description, :authors, :average_rating, 
                :isbn, :price, :published_year, :thumbnail, :stock,
                :num_pages, :ratings_count, :isbn13, :image

  # Show columns in the admin index page
  index do
    selectable_column
    id_column
    column :title
    column :authors
    column :price
    column :published_year
    column :stock
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
      # if f.object.thumbnail.present?
      #   div style: "display: flex; justify-content: center;" do
      #     image_tag(f.object.thumbnail, style: "max-width: 100px; margin: 0 auto;")
      #   end
      # end
 
      f.input :num_pages
      f.input :ratings_count
      f.input :isbn
      f.input :isbn13
      f.input :categories, as: :check_boxes, collection: Category.all.map { |category| [category.name, category.id] }
      f.input :description

    end
    f.actions
  end


  # Set up the product filters

  filter :on_sale, label: "On Sale"
  filter :new_arrivals, label: "New Arrivals"
  filter :out_of_stock, label: "Out of Stock"



end
