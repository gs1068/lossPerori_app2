RSpec.describe "StaticPages", type: :system do
  scenario "rootページアクセスに関するテスト(未ログイン)" do
    visit root_path
    aggregate_failures do
      expect(page.title).to eq "ロスペロリ"
      expect(find(".site_logo_link")[:href]).to eq root_path
      expect(page).to have_link '会員登録', href: new_user_registration_path
      expect(page).to have_link '会員登録（無料）', href: new_user_registration_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end
  end
end
