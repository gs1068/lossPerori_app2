class InquiryMailer < ApplicationMailer
  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :subject => 'お問い合わせを承りました')
  end

  def host_received_email(inquiry)
    @inquiry = inquiry
    mail(:to => Rails.application.credentials.gmail[:DEV_SMTP_USER_NAME],
         :subject => 'ユーザーからお問い合わせを承りました')
  end
end
