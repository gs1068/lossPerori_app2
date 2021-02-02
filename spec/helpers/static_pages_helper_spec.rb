RSpec.describe "application_helper", type: :helper do
  describe "ページタイトルのテスト" do
    include ApplicationHelper

    context "引数があること" do
      it "引数 - LossPerori　と表示すること" do
        expect(full_title("Test page")).to eq("Test page - LossPerori")
      end
    end

    context "引数がない場合" do
      it "LossPerori　と表示すること" do
        expect(full_title("")).to eq("LossPerori")
      end
    end

    context "nilの場合" do
      it "LossPerori　と表示すること" do
        expect(full_title(nil)).to eq("LossPerori")
      end
    end
  end
end
