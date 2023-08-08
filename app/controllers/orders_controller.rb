class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order_total = @order.total_amount
  end
  
  def new
      @user = current_user
      @cart = @user.cart
      @provinces = Province.all
      @user_addresses = @user.addresses
      @user_address = @user.addresses.find(params[:selected_address_id]) if params[:selected_address_id].present?  

      @tax_rates = @user_address.province if @user_address

      @order_total = @cart.subtotal * (1 + @tax_rates.pst + @tax_rates.gst + @tax_rates.hst) if @user_address

  end

  def create
    @cart = current_user.cart
    @user = current_user
    @order = @user.orders.create(total_amount: @cart.total_amount, status: "new")
    @cart.cart_items.each do |cart_item|
      @order.order_items.create(product: cart_item.product, quantity: cart_item.quantity, price: cart_item.product.price)
    end
    @cart.destroy
    redirect_to root_path, notice: "Order has been placed successfully."
  end

end
