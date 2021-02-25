RSpec.describe "Users", type: :request do
  let(:user) { create(:user, :add_option) }
  let(:other_user) { create(:user, :other_user) }

  before do
    user.confirm
    sign_in user
  end

  context "showページ" do
    before do
      get user_path(user.id)
    end

    it "showページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@user)).to eq user
    end
  end

  context "editページ" do
    before do
      get edit_user_path(user.id)
    end

    it "editページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@user)).to eq user
    end

    it "ログインユーザーではない場合editページにアクセス出来ないこと" do
      get edit_user_path(other_user.id)
      expect(response).not_to have_http_status(:success)
    end
  end
end
