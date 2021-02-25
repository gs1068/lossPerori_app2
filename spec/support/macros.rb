module Macros
  def register
    visit new_user_registration_path
    fill_in 'new-username', with: 'Test_User'
    fill_in 'new-email', with: 'user@testvalid.com'
    fill_in 'new-password', with: 'foobar'
    fill_in 'new-password-confirmation', with: 'foobar'
    expect { click_button '新しいアカウントを作成' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
  end

  def other_user_register
    visit new_user_registration_path
    fill_in 'new-username', with: 'Other_User'
    fill_in 'new-email', with: 'otheruser@testvalid.com'
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

  def other_user_mail_info_first_login
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content 'ログイン'
    # 登録
    fill_in 'login-email', with: 'otheruser@testvalid.com'
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
    fill_in 'ユーザー名', with: 'Test_User2'
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

  def other_user_advanced_setting
    find(".icon-box").click
    click_link "設定"
    click_link 'プロフィール変更'
    fill_in 'ユーザー名', with: 'other_user2'
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

  def listing
    click_link '食品を出品する'
    attach_file 'product[product_avatars][]', 'spec/system/test2.jpg'
    fill_in '商品名', with: 'Test-Product'
    fill_in '商品紹介', with: 'hogehogefoobar'
    fill_in '原材料', with: 'foobar'
    select '野菜or果物', from: 'カテゴリー'
    fill_in '価格', with: '1234'
    fill_in '消費期限', with: '002023-12-31'
    fill_in '総重量', with: '1.5'
    click_button '出品する'
    expect(page).to have_content 'ありがとうございます。商品の出品が完了しました。'
  end
end
