class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.gmail[:DEV_SMTP_USER_NAME]
  layout 'mailer'
end
