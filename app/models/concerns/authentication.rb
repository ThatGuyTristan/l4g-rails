module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def authenticate_user
    store_location
  end

  def forget(user)
    cookies.delete :remember_token
    user.regenerate_remember_token
  end

  def login(user)
    reset_session
    active_session = user.active_sessions.create!
    session[:current_active_session_id] = active_session.id
    session
  end

  def logout(current_active_session_id)
    active_session = ActiveSession.find_by(id: session[:current_active_session_id])
    reset_session
    active_session.destroy! if active_session.present?
  end

  def remember(user)
    user.generate_remember_token
    cookies.permanent.encrypted[:remember_token] = user.remember_token
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: "You are already logged in." if user_signed_in?
  end

  private

  #not sure if cookie logic needs to be handled here or in the FE
  def current_user
    Current.user ||= if session[:current_active_session_id].present?
      ActiveSession.find_by(id: session[:current_active_session_id]).user
    elsif cookies.permanent.encrypted[:remember_token].present?
      User.find_by(remeber_token: cookies.permanent.encrypted[:remembere_token])
    end
  end

  def store_location
    Rails.logger.debug "!!!! #{request.inspect}"
    session[:user_return_to] = request.original_url if request.get? && request.local?
  end

  def user_signed_in?
    Current.user.present? 
  end
end