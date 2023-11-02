class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: :create
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create 
    @user = User.new(create_user_params)
    if @user.save
      @user.send_confirmation_email!
      render json: { status: 200, message: "Confirmation email sent"}
    else
      render json: { status: 500, message: "user not saved"}
    end
  end

  # will be handled on the front end
  # def edit
  #   @user = current_user
  # end

  def destroy
    current_user.destroy
    reset_session
    render json: { message: "Your account has been deleted" }
  end

  def update
    @user = current_user
    if @user.authenticate?(params[:user][:current_password])
      if @user.update(update_user_params)
        if params[:user][:unconfirmed_email].present?
          @user.send_confirmation_email!
        else
          render json: { message: "Your account has been updated!" }
        end
      else
        render json: { message: "nope" }
      end
    else
      render json: { message: "incorrect password" } 
    end
  end

  private
  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
  end
end
