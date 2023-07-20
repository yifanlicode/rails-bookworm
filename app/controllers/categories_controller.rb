# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(9)
  end
end
