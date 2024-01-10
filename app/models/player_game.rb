class PlayerGame < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates_uniqueness_of :game_id, scope: :player_id
end
