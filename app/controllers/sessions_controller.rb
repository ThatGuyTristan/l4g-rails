class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if !@user 
      render json: { message: "Incorrect email or password", status: 400}
    end
    password

    if @user.unconfirmed?
      render json: { message: "User account unconfirmed.", status: 200 }
    elsif @user.authenticated(params[:user][:password])
      login @user
      render json: { message: "Login successful", status: 200 }
    else
      render json: { message: "Incorrect email or password", status: 400 }
    end
  end

  def destroy
    logout
    render json: { message: "Successfully logged out.", status: 200  }
  end

end
