class PlayerGamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    games ||= PlayerGame.includes(:game).where(player_id: params[:player_id])
    render json: { games: player_games(games)}
  end

  def create
    player_game = PlayerGame.create(player_id: params[:player_id], game_id: params[:game_id])
    
    if player_game.save!
      render json: { message: "#{player_game.game.name} added to your list"}
    end
  end

  def delete
    game_id = PlayerGame.find_by(player_id: params[:player_id], game_id: params[:game_id]).pluck(:id)
    Rails.logger.debug "#GAME #{game_id}"
    game.destroy(game_id)
  end

  # TODO: Clean this up, works as a sfd
  def player_games(games)
    actual_games = []
    games.each do |g|
      actual_games << g.game
    end
    actual_games
  end
end
