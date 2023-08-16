class OrdersController < ApplicationController

  def index
    @user = current_user
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order_total = @order.total_amount
  end
  
  def new
      @user = current_user # get the current user
      @cart = current_user.cart # get the current user's cart
      @cart_items = @cart.cart_items # get the current user's cart items

      @user_addresses = @user.addresses

      # Set default shipping address to the first address in the list
      @user_address ||= @user_addresses.first if @user_addresses.any?
      @user_address = @user.addresses.find(params[:selected_address_id]) if params[:selected_address_id].present?  

      if @user_address
        @tax_rates = @user_address.province
        @taxes = @cart.subtotal * (@tax_rates.pst + @tax_rates.gst + @tax_rates.hst)
        @order_total = @cart.subtotal * (1 + @tax_rates.pst + @tax_rates.gst + @tax_rates.hst)
      end
     
     
  end

  def create

    @order = Order.new(order_params) # create a new order with the order_params
    @order.user_id = current_user.id # set the order's user_id to the current user's id
    @order.total_amount = params[:order][:total_amount]
    @order.status = "new"
    @order.address_id = params[:order][:address_id] # Store the selected address ID
    @order_address = Address.find(@order.address_id) # Find the selected address
    @tax_rates = @order_address.province.pst + @order_address.province.gst + @order_address.province.hst
    @order.taxes = @tax_rates * @order.total_amount


    if @order.save
      @cart = current_user.cart # get the current user's cart
        @cart.cart_items.each do |cart_item|
        @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price)
        end
        @cart.cart_items.destroy_all
        
        redirect_to orders_path, notice: "Order created successfully."
        else
          flash.now[:alert] = "Error creating order."
          render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :total_amount, :status, :taxes, :address_id)
  end
  

end
