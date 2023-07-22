# app/admin/products.rb

ActiveAdmin.register Product do
  # Set the default sort order
  permit_params :title, :description, :authors, :average_rating, 
                :isbn, :price, :published_year, :thumbnail, :stock,
                :num_pages, :ratings_count, :isbn13,:discount,:on_sale,
                :image, category_ids: []
  filter :title
  filter :authors
  filter :price
  filter :published_year
  filter :stock
  
  # Show columns in the admin index page
  index do
    selectable_column
    id_column
    column :title
    column :authors
    column :price
    column :published_year
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

      if f.object.image.attached?
        div style: "display: flex; justify-content: center;" do
          # automatically resized to 200x200 pixels
          image_tag(f.object.image.variant(:thumb).processed.url)
        end
        f.input :image, as: :file, hint: "You can upload a new image "
      else
        f.input :image, as: :file
      end

      # On_sale is a boolean field, so we can use a checkbox
      f.input :on_sale, as: :boolean, input_html: { checked: false }
      f.input :discount
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

      # f.input :categories, as: :check_boxes, collection: Category.all.map { |category| [category.name, category.id] }
      f.input :categories, as: :select, input_html: { multiple: true }, collection: Category.pluck(:name, :id)
    
    end
    f.actions
  end



end
