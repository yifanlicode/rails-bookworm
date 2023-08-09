class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item

    @product = Product.find(params[:product_id])
    @cart = current_user.cart || current_user.create_cart

    # Add the product to the cart, if it's not already there
    cart_item = @cart.cart_items.find_by(product: @product)
  
    if cart_item # if the cart_item exists, increment the quantity
      cart_item.quantity ||= 1 # if quantity is nil, set it to 1
      cart_item.quantity += 1 # increase the quantity by 1

    else
      cart_item = @cart.cart_items.build(product: @product, quantity: 1)
    end
  
    if cart_item.save
      redirect_to product_path(@product), notice: 'Item added to cart.'
    else
      redirect_to product_path(@product), alert: 'Failed to add item to cart.'
    end
  end

  
  def remove_item
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
  
    @cart_item.destroy
    flash[:notice] = "Item removed from cart."
    redirect_to cart_path
   
  end

  def update_item_quantity
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
  
    quantity = params[:quantity].to_i
  
    @cart_item.update(quantity: quantity)
    flash[:notice] = "Item quantity updated."
  
    if request.referer.include?("cart") # If user was on cart page
      redirect_to cart_path
    elsif request.referer.include?("orders/new") # If user was on order page
      redirect_to new_order_path
    else
      redirect_back(fallback_location: root_path) # Default fallback
    end
  end
  
  
end
