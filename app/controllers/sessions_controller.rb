class SessionsController < ApplicationController
  before_action :authenticate_user, only: :destroy

  skip_before_action :verify_authenticity_token

  # TODO: figure this out before we launch beta!!!
  # skip_forgery_protection only: [:create, :destroy]

  def create
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])

    if !@user 
      render json: { message: "Incorrect email or password", status: 400}
    end

    if @user.unconfirmed?
      render json: { message: "User account unconfirmed.", status: 200 }
    elsif @user.authenticate(params[:user][:password])
      token = login @user
      remember(@user) if params[:user][:remember_me] == 1
      render json: { message: "Login successful", status: 200, token: token }
    else
      render json: { message: "Incorrect email or password", status: 400 }
    end
  end

  def destroy
    logout(params[:current_active_session_id])
    render json: { message: "Successfully logged out.", status: 200  }
  end
end
