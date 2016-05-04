class UserHttpMailer
  include RenderAnywhere

  def initialize(user)
    @user = user
  end

  def welcome_email
    connection.post do |request|
      request.body = welcome_params
    end
  rescue Faraday::Error
    nil
  end

  private

  def welcome_params
    {
      from: Settings.mailer.from.no_reply,
      to: @user.email,
      subject: I18n.t('user_mailer.welcome.subject'),
      html: welcome_body
    }
  end

  def connection
    params = {
      request: {
        open_timeout: 10,
        timeout: 10
      }
    }
    @connection ||= Faraday.new(Figaro.env.smtp_api_url, params)
  end

  def welcome_body
    params = { :@user => @user, :@host => Settings.host }
    render('user_mailer/welcome_email', layout: 'mailer', locals: params)
  end
end
