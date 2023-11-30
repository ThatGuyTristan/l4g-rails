class ConfirmationsController < ApplicationController
  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email! 
      render json: { message: "Invitation sent! Check your inbox for a confirmation email."}
    else
      render json: { message: "We could not find a user with that email address."}
    end
  end

  def edit
    Rails.logger.debug "FIRE AT WILL"
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present? && @user.unconfirmed_or_reconfirming?
      @user.confirm!
      login @user
      render json: { message: "Your account has been confirmed."}
    else
      render json: { message: "Invalid token."}
    end
  end
end
  
