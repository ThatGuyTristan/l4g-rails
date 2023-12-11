class System < ApplicationRecord
  has_many :games

  SYSTEMS_BY_ID = ['Xbox', 'Playstation', 'Switch']

end
