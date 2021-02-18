module LoginMacros
  def register
    visit new_user_registration_path
    fill_in 'new-username', with: 'Test-User'
    fill_in 'new-email', with: 'user@testvalid.com'
    fill_in 'new-password', with: 'foobar'
    fill_in 'new-password-confirmation', with: 'foobar'
    expect { click_button '新しいアカウントを作成' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
  end

  def mail_info_first_login
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content 'ログイン'
    # 登録
    fill_in 'login-email', with: 'user@testvalid.com'
    fill_in 'login-password', with: 'foobar'
    click_button 'ログイン'
  end

  def login
    click_link 'ログイン'
    fill_in 'login-email', with: 'user@testvalid.com'
    fill_in 'login-password', with: 'foobar'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
  end

  def advanced_setting
    find(".icon-box").click
    click_link "設定"
    click_link 'プロフィール変更'
    fill_in 'ユーザー名', with: 'Test-User2'
    fill_in '自己紹介', with: 'よろしくお願いいたします'
    fill_in '郵便番号', with: '1234567'
    select '東京', from: '都道府県'
    fill_in '市区町村', with: 'foobar'
    fill_in '番地', with: '12-34-5'
    fill_in '建物名', with: 'テストコーポ103'
    click_button '更新'
    expect(page).to have_content 'プロフィール'
    expect(page).to have_content 'プロフィールを変更しました'
  end

  def logout
    find(".icon-box").click
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end
