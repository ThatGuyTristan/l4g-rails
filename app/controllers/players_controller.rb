class PlayersController < ApplicationController

  def index
    @players ||= Player.find_by(id: params[:ids])
  end

  def show
    if !user.confirmed?
      render json: { message: "Please confirm your email to access your profile."}
    end

    @player ||= Player.find_by(id: params[:id]).or(Player.find_by(user_id: params[:user_id]))
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
