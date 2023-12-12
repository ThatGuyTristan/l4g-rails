class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    render json: { games: Game.all.limit(30) }
  end 
end
