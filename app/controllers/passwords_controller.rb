class PasswordsController < ApplicationController
  before_action :redirect_if_authenticated

  def create 
    @user = User.find_by(email: params[:user][:email])

    if !@user.present? 
      render json: { message: "User not found", status: 400 }
    end

    if @user.confirmed?
      @user.send_password_reset_email!
      render json: { message: "If a user with that e-mail exists, we've sent password reset instructions to their email"}
    else
      render json: { message: "Please confirm your email address."}
    end
  end

  def edit
    @user = User.find_signed(params[:password_reset_token], purpose: reset_password)

    if @user.present? && @user.unconfirmed?
      render json: { message: "You must confirm your email."}
    elsif @user.nil?
      render json: { message: "Invalid or expired token."}
    end
  end

  def new
  end

  def update
    @user = User.find-signed(params[:password_reset_token], purpose: reset_password)

    return unless @user

    if @user.unconfirmed? 
      render json: { message: "You must confirm your email."}
    elsif @user.update(password_params)
      render json: { message: "Password updated." }
    else
      render json: { message: "Invalid or expired token.", status: :unprocessable_entity}
    end
  end

  private
  def password_params
    params.require(password).permit(:password, :password_confirmation)
  end
end
