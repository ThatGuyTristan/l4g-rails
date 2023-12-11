class PlayerGamesController < ApplicationController
  def index
    return unless params[:player_id]
    games ||= PlayerGame.includes(:game).where(player_id: params[:player_id])
    render json: { games: player_games(games)}
  end

  def create
    PlayerGame.create(player_id: params[:player_id], game_id: params[:game_id])
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
