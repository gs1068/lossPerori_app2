RSpec.describe User, type: :model do
  describe "ユーザー関連テスト" do
    let(:user) { build(:user) }

    it "ユーザーが有効である" do
      expect(user).to be_valid
    end

    it "名前が空欄だと無効にする" do
      user.username = '  '
      expect(user).to be_invalid
    end

    it '名前が51文字以上だと無効にする' do
      user.username = 'a' * 51
      expect(user).to be_invalid
    end

    it "メールアドレスが空欄だと無効にする" do
      user.email = '  '
      expect(user).to be_invalid
    end

    it 'メールアドレスが192文字以上だと無効にする' do
      user.email = 'a' * 180 + 'example.com'
      expect(user).to be_invalid
    end

    it "PWが空欄だと無効にする" do
      user.password = '  '
      expect(user).to be_invalid
    end

    it 'PWが5文字以下なら無効にする' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).to be_invalid
    end

    it '自己紹介が192文字以上だと無効にする' do
      user.intro = 'a' * 192
      expect(user).to be_invalid
    end

    it 'メールアドレスは有効なフォーマットのみ有効にする' do
      valid_addresses = %w(
        user@example.com USER@foo.COM
        A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn
      )
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'メールアドレスは無効なフォーマットは無効にする' do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to be_invalid
      end
    end

    it "他ユーザーの複製は無効にする" do
      duplicate_user = user.dup
      user.save
      expect(duplicate_user).to be_invalid
    end
  end
end
