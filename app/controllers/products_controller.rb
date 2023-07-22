class ProductsController < ActionController::Base
  layout 'application'

  def index
    @products = Product.page(params[:page]).per(12)
  
    @products = case params[:filter]
    when 'on_sale'
      @products.on_sale.order(price: :asc)
    when 'new_products'
      @products.created_in_last_days(3)
    when 'recently_updated'
      @products.updated_in_last_days(3)
    else
      @products
    end
  
    @products = @products.page(params[:page]).per(12)
    @sidebar_categories = Category.left_joins(:products).group(:id).order('COUNT(products.id) DESC').limit(10)
  end
  
  def discounted_price
    discounted_price = price - (price * discount)
    discounted_price.round(2) # Round the discounted price to 2 decimal places
  end

  def show
    @product = Product.find(params[:id])
  end



  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(12)
    render 'categories/show'
  end

end

