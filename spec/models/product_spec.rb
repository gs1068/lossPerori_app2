RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  let!(:day_before_yesterday) { create(:product, :day_before_yesterday) }
  let!(:now) { create(:product, :now) }
  let!(:yesterday) { create(:product, :yesterday) }

  it "商品が有効である" do
    expect(product).to be_valid
  end

  it "ユーザーidがnilの場合は商品が無効になる" do
    product.user_id = nil
    expect(product).to be_invalid
  end

  it "商品名がない場合は商品が無効になる" do
    product.product_name = "   "
    expect(product).to be_invalid
  end

  it "商品紹介がない場合は商品が無効になる" do
    product.product_intro = "   "
    expect(product).to be_invalid
  end

  it "商品紹介が401文字以上の場合は商品が無効になる" do
    product.product_intro = "a" * 401
    expect(product).to be_invalid
  end

  it "レコードがcreated_at順である" do
    users = Product.sorted.first
    expect(users).to eq now
  end
end
