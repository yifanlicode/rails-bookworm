class HomeController < ApplicationController

  layout 'application'
  
  def index
    @products = Product.page(params[:page]).per(30)
  end

  def about
    @about = About.first
  end

  def contact
    @contact = Contact.first
  end

end