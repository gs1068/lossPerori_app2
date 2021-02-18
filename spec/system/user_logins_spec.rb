RSpec.describe 'StaticPages/UsersLogin/UserDestroy', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario 'rootページ/ログイン/削除一連のテスト' do
    # 未ログインのroot_page
    visit root_path
    expect(page.title).to eq 'ロスペロリ'
    expect(find('.site_logo_link')[:href]).to eq root_path
    expect(page).to have_link '会員登録', href: new_user_registration_path
    expect(page).to have_link '会員登録（無料）', href: new_user_registration_path
    expect(page).to have_link 'ログイン', href: new_user_session_path
    click_link '会員登録（無料）'
    expect(current_path).to eq new_user_registration_path

    # 登録失敗
    fill_in 'new-username', with: '   '
    fill_in 'new-email', with: 'user@invalid'
    fill_in 'new-password', with: 'hoo'
    fill_in 'new-password-confirmation', with: 'hoo'
    click_button '新しいアカウントを作成'
    expect(current_path).to eq '/users'
    expect(page).to have_content '新規アカウントを作成'
    expect(page).to have_content '3 件のエラーが発生したため アカウント は保存されませんでした。'

    # 登録成功
    register

    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content 'ログイン'

    # ログイン失敗
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'

    # 登録に成功する
    fill_in 'login-email', with: 'user@testvalid.com'
    fill_in 'login-password', with: 'foobar'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    # ログイン後のroot_page
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content 'Test-User'
    expect(page).to have_link 'ログアウト', href: destroy_user_session_path

    # ログアウト
    logout

    # 再ログイン
    login

    # 削除
    # ユーザーページに移動
    find(".icon-box").click
    click_link "設定"
    expect { click_link 'アカウントを削除する' }.to change { User.all.size }.by(-1)
  end
end
