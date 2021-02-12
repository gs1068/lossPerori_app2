RSpec.describe 'UsersAdvancedSetting', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario 'ユーザー設定' do
    # 登録成功
    visit new_user_registration_path
    fill_in 'new-username', with: 'Test-User'
    fill_in 'new-email', with: 'user@testvalid.com'
    fill_in 'new-password', with: 'foobar'
    fill_in 'new-password-confirmation', with: 'foobar'
    expect { click_button '新しいアカウントを作成' }.to change { ActionMailer::Base.deliveries.size }.by(1)

    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content 'ログイン'

    # 登録
    fill_in 'login-email', with: 'user@testvalid.com'
    fill_in 'login-password', with: 'foobar'
    click_button 'ログイン'

    # ユーザーページに移動
    find(".icon-box").click
    click_link "設定"
    expect(page).to have_content 'こんにちはTest-Userさん、'
    expect(page).to have_content 'アカウント'
    click_link 'アカウントを編集する'

    # アカウント編集ページに移動
    # 無効な編集
    expect(page).to have_content 'アカウント編集'
    fill_in 'メールアドレス', with: ''
    fill_in '新しいパスワード', with: ''
    fill_in 'パスワード確認', with: ''
    click_button '更新'
    expect(page).to have_content 'アカウント編集'
    expect(page).to have_content '2 件のエラーが発生したため アカウント は保存されませんでした。'

    # 有効な編集（パスワード入力なしで変更できる）
    expect(page).to have_content 'アカウント編集'
    fill_in 'メールアドレス', with: 'user2@testvalid.com'
    fill_in '新しいパスワード', with: ''
    fill_in 'パスワード確認', with: ''
    click_button '更新'
    expect(current_path).to eq root_path
    expect(page).to have_content 'アカウント情報を変更しました。'

    # 有効な編集（パスワード変更）あり
    find(".icon-box").click
    click_link "設定"
    click_link 'アカウントを編集する'
    expect(page).to have_content 'アカウント編集'
    fill_in 'メールアドレス', with: 'user2@testvalid.com'
    fill_in '新しいパスワード', with: 'hogehoge'
    fill_in 'パスワード確認', with: 'hogehoge'
    click_button '更新'
    expect(current_path).to eq root_path
    expect(page).to have_content 'アカウント情報を変更しました。'

    # オプションの設定
    find(".icon-box").click
    click_link "設定"
    click_link 'プロフィール変更'
    fill_in 'ユーザー名', with: 'Test-User2'
    fill_in '自己紹介', with: 'よろしくお願いいたします'
    fill_in '郵便番号', with: '1234567'
    fill_in '市区町村', with: '09'
    fill_in '番地', with: '12-34-5'
    fill_in '建物名', with: 'テストコーポ103'
    click_button '更新'
    expect(page).to have_content 'プロフィール'
    expect(page).to have_content 'プロフィールを変更しました'
  end
end
