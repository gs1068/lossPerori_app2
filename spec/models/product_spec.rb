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

  it "原材料がない場合は商品が無効になる" do
    product.raw_material = "   "
    expect(product).to be_invalid
  end

  it "カテゴリーがない場合は商品が無効になる" do
    product.categories = "　　　　"
    expect(product).to be_invalid
  end

  it "価格がない場合は商品が無効になる" do
    product.fee = "   "
    expect(product).to be_invalid
  end

  it "価格が数字以外の場合は商品が無効になる" do
    product.fee = "foobar"
    expect(product).to be_invalid
  end

  it "レコードがcreated_at順である" do
    users = Product.sorted.first
    expect(users).to eq now
  end

  it "画像は4枚より多い場合は無効になる" do
    product.product_avatars = [
      Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test.jpg'), 'spec/system/test.jpg'),
      Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test2.jpg'), 'spec/system/test2.jpg'),
      Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test3.jpg'), 'spec/system/test3.jpg'),
      Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test4.jpg'), 'spec/system/test4.jpg'),
      Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test5.jpg'), 'spec/system/test5.jpg'),
    ]
    expect(product).to be_invalid
  end
end
