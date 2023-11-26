class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  before_save :downcase_email

  has_secure_password

  has_one :player

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  def confirm!
    update_columns(confirmed_at: Time.current)
    create_player
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: confirm_email
  end

  def unconfirmed?
    !confirmed?
  end 

  def create_player
    if !user.player
      @player = Player.new(user_id: user.id)
      @player.save!
    end
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
