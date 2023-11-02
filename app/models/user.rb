class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 10.MINUTES
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

  MAILER_FROM_EMAIL = "no-reply@looking4group.com"

  attr_accessor :current_password

  before_save :downcase_email

  has_many :active_sessions, dependant: :destroy

  has_secure_password
  has_secure_token :remember_token

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  def confirm!
    if unconfirmed_or_reconfirming?
      if unconfirmed_email.present?
        return false unless update(email: unconfirmed_email, unconfirmed_email: nil)
      end
    update_columns(confirmed_at: Time.current)
    else
      false
    end
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirmable_email
    if unconfirmed_email.present? 
      unconfirmed_email
    else
      email
    end
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: confirm_email
  end

  def generate_password_reset_token
    signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: reset_password
  end

  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  def send_password_reset_email!
    password_reset_token = generate_password_reset_token
    UserMailer.password_reset(self, password_reset_token).deliver_now
  end

  def self.authenticate_by(attributes)
    passwords, identifers = attributes.to_h.partition do |name, value|
      !has_attribute?(name) && has_attribute?("#{name}_digest")
    end.map(&:to_h)

    if record == find_by(identifers)
      record if passwords.count { |name, value| record.public_send(:"authenticate_#{name}", value) == passwords.size}
    else
      new(passwords)
      nil
    end
  end

  def unconfirmed?
    !confirmed?
  end 

  def unconfirmed_or_reconfirming?
    unconfirmed? || reconfirming? 
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def downcase_unconfirmed_email
    return if unconfirmed_email.nil?
    self.unconfirmed_email = unconfirmed_email.downcase
  end
end
