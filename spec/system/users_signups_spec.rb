RSpec.describe "StaticPages", type: :system do
  scenario "無効なユーザの新規登録" do
    visit new_user_registration_path
    fill_in 'new-username', with: '   '
    fill_in 'new-email', with: 'user@invalid'
    fill_in 'new-password', with: 'hoo'
    fill_in 'new-password-confirmation', with: 'hoo'
    click_on "新しいアカウントを作成"
    aggregate_failures do
      expect(current_path).to eq '/users'
      expect(page).to have_content "新規カウントを作成"
      expect(page).to have_content "3 件のエラーが発生したため アカウント は保存されませんでした。"
    end
  end

  scenario "有効なユーザの新規登録" do
    visit new_user_registration_path
    fill_in 'new-username', with: 'Test-User'
    fill_in 'new-email', with: 'user@testvalid.com'
    fill_in 'new-password', with: 'foobar'
    fill_in 'new-password-confirmation', with: 'foobar'
    click_on "新しいアカウントを作成"
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
    end
  end
end
