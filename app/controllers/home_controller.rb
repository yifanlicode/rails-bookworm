class HomeController < ApplicationController
  def index
  end

  def about
    @about = About.first
  end

  def contact
    @contact = Contact.first
  end

end