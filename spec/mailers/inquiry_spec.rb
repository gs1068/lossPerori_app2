RSpec.describe InquiryMailer, type: :mailer do
  before do
    @user = Inquiry.new(name: "TestUser", email: "testuser@test.com", message: "foobar")
  end

  describe "ユーザー側お問い合わせの送信" do
    let(:mail_user) { InquiryMailer.received_email(@user) }

    it "ユーザへ正常にメールが送信されること" do
      expect(mail_user.subject).to eq "お問い合わせを承りました"
      expect(mail_user.to).to eq([@user.email])
      expect(mail_user.from).to eq([Rails.application.credentials.gmail[:DEV_SMTP_USER_NAME]])
      expect(mail_user.body.encoded).to match @user.name
      expect(mail_user.body.encoded).to match @user.email
      expect(mail_user.body.encoded).to match @user.message
    end
  end

  describe "管理側お問い合わせの送信" do
    let(:mail_host) { InquiryMailer.host_received_email(@user) }

    it "管理側へ正常にメールが送信されること" do
      expect(mail_host.subject).to eq "ユーザーからお問い合わせを承りました"
      expect(mail_host.to).to eq([Rails.application.credentials.gmail[:DEV_SMTP_USER_NAME]])
      expect(mail_host.from).to eq([Rails.application.credentials.gmail[:DEV_SMTP_USER_NAME]])
      expect(mail_host.body.encoded).to match @user.name
      expect(mail_host.body.encoded).to match @user.email
      expect(mail_host.body.encoded).to match @user.message
    end
  end
end
