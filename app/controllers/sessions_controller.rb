class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]
  before_action :authenticate_user, only: :destroy

  def create
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])

    if !@user 
      render json: { message: "Incorrect email or password", status: 400}
    end
    # password ?????? 

    if @user.unconfirmed?
      render json: { message: "User account unconfirmed.", status: 200 }
    elsif @user.authenticate(params[:user][:password])
      login @user
      remember(@user) if params[:user][:remember_me] == 1
      render json: { message: "Login successful", status: 200 }
    else
      render json: { message: "Incorrect email or password", status: 400 }
    end
  end

  def destroy
    forget(current_user)
    logout
    render json: { message: "Successfully logged out.", status: 200  }
  end
end
