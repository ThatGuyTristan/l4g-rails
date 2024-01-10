class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]
  before_action :authenticate_user, only: :destroy

  # TODO: figure this out before we launch beta!!!
  skip_forgery_protection only: [:create, :destroy]

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
      render json: { message: "Login successful", status: 200, token: token, player: @user.player }
    else
      render json: { message: "Incorrect email or password", status: 400 }
    end
  end

  def destroy
    # forget(current_user)
    logout(params[:current_active_session_id])
    render json: { message: "Successfully logged out.", status: 200  }
  end
end
