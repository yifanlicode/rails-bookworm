class UsersController < ApplicationController


    def update
      @user = current_user
      @user.build_address if @user.address.nil?
      if @user.update(user_params)
        redirect_to root_path, notice: "Address has been saved successfully."
      else
        render :edit
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, address_attributes: [:address_line_1, :address_line_2, :city, :province_id, :postal_code])
    end

end
  