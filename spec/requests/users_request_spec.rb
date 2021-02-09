RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    user.confirm
    sign_in user
    get user_path(user.id)
  end

  context "showページ" do
    it "showページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@user)).to eq user
    end
  end

  context "editページ" do
    it "editページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@user)).to eq user
    end
  end
end
