class Game < ApplicationRecord
  belongs_to :system
  has_and_belongs_to_many :players, :join_table => :players_games
end