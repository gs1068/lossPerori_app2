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
    register

    # メール情報取得/ユーザー認証
    mail_info_first_login

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
    advanced_setting
  end
end
