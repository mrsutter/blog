class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @host = default_url_options[:host]
    mail(
      to: @user.email,
      subject: I18n.t('user_mailer.welcome.subject')
    )
  end
end
