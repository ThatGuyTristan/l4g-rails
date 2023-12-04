class Player < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :games, :join_table => :players_games
  scope :public_profile, -> { where(public: true) }

  def email
    user.email
  end
end
