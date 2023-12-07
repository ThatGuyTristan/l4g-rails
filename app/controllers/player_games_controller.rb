class PlayerGamesController < ApplicationController
  
  def player_games(player_id)
    games ||= PlayerGames.find_by(player_id: player_id).includes(:games)
  end

end

