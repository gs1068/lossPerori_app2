RSpec.describe "application_helper", type: :helper do
  describe "ページタイトルのテスト" do
    include ApplicationHelper

    context "引数があること" do
      it "引数 - ロスペロリ　と表示すること" do
        expect(full_title("Test page")).to eq("Test page - ロスペロリ")
      end
    end

    context "引数がない場合" do
      it "ロスペロリ　と表示すること" do
        expect(full_title("")).to eq("ロスペロリ")
      end
    end

    context "nilの場合" do
      it "ロスペロリ　と表示すること" do
        expect(full_title(nil)).to eq("ロスペロリ")
      end
    end
  end
end
