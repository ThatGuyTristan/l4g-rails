class ApplicationController < ActionController::Base
  include Authentication

  def render_success(data)
    render json: { data: data }
  end

  def render_error(error)
    render json: { error: error}
  end
end
