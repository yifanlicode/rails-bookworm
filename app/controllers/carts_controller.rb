class CartsController < ApplicationController
  before_action :authenticate_user!


  def show
    @cart = current_user.cart
  end

  def add_item
    @product = Product.find(params[:product_id])
    @cart = current_user.cart

    # Add the product to the cart, if it's not already there
    cart_item = @cart.cart_items.find_by(product: @product)
  
    if cart_item # if the cart_item exists, increment the quantity
      cart_item.quantity ||= 1 # if quantity is nil, set it to 1
      cart_item.quantity += 1 # increase the quantity by 1
      flash[:notice] = 'Item quantity updated.'
    else
      cart_item = @cart.cart_items.build(product:@product, quantity: 1) 
    end
  
    if cart_item.save
      redirect_to cart_path(@cart), notice: 'Item added to cart.'
    else
      redirect_to product_path(@product), alert: 'Unable to add item to cart.'
    end
  end


  def remove_item
    @product = Product.find(:product_id)
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(product: @product)

    if @cart_item
      @cart_item.destroy
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found in cart. Unable to remove."
    end
    
    redirect_to cart_path(@cart)
  end


  def update_item_quantity
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(product: @product)

    if @cart_item
      @cart_item.update(quantity: params[:quantity].to_i)
      flash[:notice] = "Item quantity updated."
    else 
      flash[:alert] = "Item not found in cart. Unable to update quantity."  
    end

    redirect_to cart_path(@cart)
  end


end
