class ApplicationController < ActionController::Base
  include Authentication

  def render_success(data={})
    render json: data, status: 200
  end

  def render_error(errors) 
    render json: { errors: errors }, status: 400
  end
end
