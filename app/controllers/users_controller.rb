class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create]

  def create 
    @user = User.new(user_params)
    if @user.save
      render json: { status: 200, message: "user saved"}
    else
      render json: { stauts: 500, message: "user not saved"}
    end
  endtest

  private
  def user_params
    params.require(user).permit(:email, :password, :password_confirmation)
  end
end
