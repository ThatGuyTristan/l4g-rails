class SessionsController < ApplicationController
  before_action :authenticate_user, only: :destroy

  # TODO: consult
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])

    if !@user 
      render_error("Incorrect email or password")
    end

    if @user.unconfirmed?
      render_error('User account unconfirmed')
    elsif @user.authenticate(params[:user][:password])
      token = login @user
      remember(@user) if params[:user][:remember_me] == 1
      render_success({ message: "Login successful", sessionId: token.session_id, userId: @user.id, playerId: @user.player.id })
    else
      render_error("Incorrect email or password")
    end
  end

  def destroy
    logout(params[:current_active_session_id])
    render_success(message: "Successfully logged out.")
  end
end
