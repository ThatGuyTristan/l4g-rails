class Player < ApplicationRecord
  belongs_to :user

  scope :public_profile, -> { where(public: true) }

  def email
    user.email
  end
end
