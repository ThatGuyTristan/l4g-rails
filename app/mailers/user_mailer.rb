class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: "Confirmation Instructions"
  end

  def password_reset(user, password_reset_token)
    @user = user
    @password_reset_token = password_reset_token

    mail to: @user.email, subject: "Reset Password Instructions"
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.user_mailer.confirmation.subject
end
