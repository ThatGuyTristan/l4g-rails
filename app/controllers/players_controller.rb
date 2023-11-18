class PlayersController < ApplicationController

  def index
    @players ||= Player.find_by(id: params[:ids])
  end

  def show
    @player ||= Player.find_by(id: params[:id])
    render json: { item: @player }
  end

  def edit
    @player ||= Player.find_by(id: params[:id])
    @player.save!
  end

  private 
  def player_params
    params.require(player).permit(:username, :headline, :timezone, :playstyle, :pfp_src, :bio)
  end

end
