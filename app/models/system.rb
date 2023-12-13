class System < ApplicationRecord
  has_many :games

  SYSTEMS = ['Xbox', 'Playstation', 'Switch', 'PC']

end
