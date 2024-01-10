class Player < ApplicationRecord
  belongs_to :user

  has_many :player_games
  has_many :games, :through => :player_games
  has_many :systems
  
  scope :public_profile, -> { where(public: true) }

  # TODO: finalize these scopes 
  # scope :by_game, -> (game_id) { joins(:player_game).where(player_games: { game_id: game_id }) }
  # scope :by_system, -> (system_id) { joins(:player_system).where(player_system: {system_id: system_id })) }
  
  def email
    user.email
  end
end
