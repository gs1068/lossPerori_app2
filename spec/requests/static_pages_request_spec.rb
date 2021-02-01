RSpec.describe "StaticPages", type: :request do
  describe "rootパスからホームページにアクセスできること" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
