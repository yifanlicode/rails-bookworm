# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController

  def index
    @categories = Category.left_joins(:products).group(:id).order('COUNT(products.id) DESC').limit(20)
  end


  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(12)

    # Fetch the top categories for the sidebar
    @sidebar_categories = Category.left_joins(:products).group(:id).order('COUNT(products.id) DESC').limit(10)

  end
end
