class ProductsController < ActionController::Base
  layout 'application'
  
  def index

    @products = Product.page(params[:page]).per(12)


    if params[:keyword].present?
      keyword = params[:keyword].strip.downcase.gsub(/\s+/, " ")
      @products = @products.where("lower(title) LIKE :search", search: "%#{keyword}%")
    end
  
    if params[:category].present? && params[:category] != 'All'
      category_name = params[:category]
      @products = @products.joins(:categories).where("categories.name = ?", category_name)
    end


    apply_filter(params[:filter])  
    @sidebar_categories = Category.left_joins(:products)
                      .group(:id)
                      .order('COUNT(products.id) DESC').limit(10)
  end

  def show
    @product = Product.find(params[:id])

  end


private

  def apply_filter(filter)
    case filter
    when 'on_sale'
      @products = @products.on_sale.order(price: :asc)
    when 'new_products'
      @products = @products.created_in_last_days(3)
    when 'recently_updated'
      @products = @products.updated_in_last_days(3).where.not(id: @products.created_in_last_days(3).pluck(:id))
    end
  end

  
end

