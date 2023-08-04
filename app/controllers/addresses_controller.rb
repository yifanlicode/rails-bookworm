class AddressesController < ApplicationController
  before_action :authenticate_user! 

  def new
    @address = current_user.addresses.build
    @user_addresses = current_user.addresses.limit(3)
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to new_address_path, notice: "Address was successfully created."
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:full_name, :address_line_1, :address_line_2, :city, :postal_code, :province_id, :phone_number)
  end
  
end
