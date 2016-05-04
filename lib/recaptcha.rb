class Recaptcha
  class << self
    def verify(model_instance, recaptcha_response)
      options = {
        secret:  Figaro.env.recaptcha_private_key,
        response: recaptcha_response
      }
      response = remote_verify(model_instance, options)

      return false if response.nil?
      return true if response['success']

      add_error(model_instance, I18n.t('recaptcha.verification_failed'))
      false
    end

    private

    def remote_verify(model_instance, options)
      connection = Faraday.new(Settings.recaptcha_api)
      response = connection.post do |request|
        request.body = options
      end
      return JSON.parse(response.body) if response.status == 200

      add_error(model_instance, I18n.t('recaptcha.unreachable'))
      nil
    rescue Faraday::Error
      add_error(model_instance, I18n.t('recaptcha.unreachable'))
      nil
    end

    def add_error(model_instance, error)
      model_instance.errors.add(:captcha, error)
    end
  end
end
