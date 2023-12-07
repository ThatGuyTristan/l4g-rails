class Player < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :games, :join_table => :player_games
  
  scope :public_profile, -> { where(public: true) }
  # TODO: Consult w/ srs on this
  # scope :by_game, -> (game_id) { joins(:player_game).where(player_games: { game_id: game_id }) }

  def email
    user.email
  end
end
