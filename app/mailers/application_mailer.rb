class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.from.no_reply
  layout 'mailer'
end
