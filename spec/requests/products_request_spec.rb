RSpec.describe "Products", type: :request do
  let(:user) { create(:user, :add_option) }
  let(:product) { create(:product) }
  let!(:day_before_yesterday) { create(:product, :day_before_yesterday) }
  let!(:now) { create(:product, :now) }
  let!(:yesterday) { create(:product, :yesterday) }

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
  end
end
