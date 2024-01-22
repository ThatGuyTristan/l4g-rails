class ApplicationController < ActionController::Base
  include Authentication

  def render_success(obj)
    render json: obj, status: :ok
  end

  def render_error(error)
    render json: error, status: :unprocessible_entity
  end
end
