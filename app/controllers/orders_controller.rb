class OrdersController < ApplicationController

  def index
    @user = current_user
    @orders = current_user.orders.order(created_at: :desc)
    @tax_rate = 0.13
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order_total = @order.total_amount
  end
  
  def new
      @user = current_user
      @cart = current_user.cart
      @cart_items = @cart.cart_items

      @provinces = Province.all
      @user_addresses = @user.addresses
      @user_address = @user.addresses.find(params[:selected_address_id]) if params[:selected_address_id].present?  

      @tax_rates = @user_address.province if @user_address
      @taxes = @cart.subtotal * (@tax_rates.pst + @tax_rates.gst + @tax_rates.hst) if @user_address
      @order_total = @cart.subtotal * (1 + @tax_rates.pst + @tax_rates.gst + @tax_rates.hst) if @user_address
     
      
  end

  def create

    @order = Order.new(order_params) # create a new order with the order_params
    @cart = current_user.cart 
    @user = current_user

    @order.user_id = current_user.id
    @order.status = "new"

    # Calculate taxes here
    @user_address = @user.addresses.find(params[:selected_address_id]) if params[:selected_address_id].present?  
    @tax_rates = @user_address.province if @user_address
    @taxes = @cart.subtotal * (@tax_rates.pst + @tax_rates.gst + @tax_rates.hst) if @user_address

    @order.address_id = @user_address.id if @user_address

    if @order.save
      if @cart
        @cart.cart_items.each do |cart_item|
        @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price)
      end
      @cart.destroy # destroy the cart after the order is created
     end
      redirect_to orders_path, notice: "Order created successfully."
    else
      flash.now[:alert] = "Error creating order."
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :total_amount, :status, :address_id)
  end
  

end
