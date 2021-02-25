RSpec.describe "Products", type: :request do
  let(:user) { create(:user, :add_option) }
  let(:other_user) { create(:user, :other_user) }
  let(:product) { create(:product, user: user) }
  let!(:day_before_yesterday) { create(:product, :day_before_yesterday, user: user) }
  let!(:now) { create(:product, :now, user: user) }
  let!(:yesterday) { create(:product, :yesterday, user: user) }
  let!(:other_user_product) { create(:product, :other_user_product, user: other_user) }

  before do
    user.confirm
    sign_in user
  end

  context "商品詳細ページ" do
    before do
      get product_path(product.id)
    end

    it "商品詳細ページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@product)).to eq product
    end
  end

  context "商品一覧ページ" do
    before do
      get products_path(product.id)
    end

    it "商品一覧ページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      products = controller.instance_variable_get(:@products)
      expect(products.first).to eq now
    end
  end

  context "商品編集ページ" do
    before do
      get edit_product_path(product.id)
    end

    it "商品編集ページにアクセス出来ていること" do
      expect(response).to have_http_status(:success)
    end

    it "インスタンス変数が定義されていること" do
      expect(controller.instance_variable_get(:@product)).to eq product
    end

    it "自分の商品出ない場合編集ページにアクセス出来ないこと" do
      get edit_product_path(other_user_product.id)
      expect(response).not_to have_http_status(:success)
    end
  end
end
