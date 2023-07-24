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
  
    if @cart_item
      @cart_item.destroy
      redirect_to cart_path(@cart), notice: "Item removed from cart."
    else
      redirect_to cart_path(@cart), alert: "Item not found in cart. Unable to remove item."
    end
  end


  def update_item_quantity
    @cart = current_user.cart
    # 坑,之前发了错误,传递的参数是id,而不是product_id
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
  
    #坑 2 之前没有准确的写出q(quantity: quantity) 正确的参数

      quantity = params[:quantity].to_i
  
       @cart_item.update(quantity: quantity)
      redirect_to cart_path(@cart), notice: "Item quantity updated."
  end
    
  
end
