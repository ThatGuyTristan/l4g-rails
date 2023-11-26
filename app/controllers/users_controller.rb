class UsersController < ApplicationController
  def create 
    @user = User.new(user_params)
    if @user.save
      @user.send_confirmation_email!
      render json: { status: 200, message: "Confirmation email sent"}
    else
      render json: { stauts: 500, message: "user not saved"}
    end
  end

  def show
    @user = User.find_by(id: params[:user][:id])
    render json: { id: @user.id, confirmed: @user.confirmed_at ? 1 : 0, email: @user.email }
  end

  private
  def user_params
    params.require(user).permit(:email, :password, :password_confirmation)
  end
end
