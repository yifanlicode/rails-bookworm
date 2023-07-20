class ProductsController < ActionController::Base
  layout 'application'

  def index
    @products = Product.page(params[:page]).per(9)
  end

  def show
    @product = Product.find(params[:id])
  end

  def by_category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(9)
    render 'categories/show'
  end

end

