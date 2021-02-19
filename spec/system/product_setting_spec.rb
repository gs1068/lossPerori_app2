RSpec.describe 'ProductsSetting', type: :system do
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
    # オプションの設定
    advanced_setting

    # 無効な商品の出品
    click_link '食品を出品する'
    fill_in '商品名', with: ''
    fill_in '商品紹介', with: ''
    fill_in '原材料', with: ''
    select '選択して下さい', from: 'カテゴリー'
    fill_in '価格', with: ''
    fill_in '消費期限', with: ''
    fill_in '総重量', with: ''
    click_button '出品する'
    expect(page).to have_content '食品の出品'
    expect(page).to have_content 'エラーが10個あります。'

    # 有効な商品の出品
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

    # 商品の編集
    user = User.first
    product = user.products.first

    visit new_user_session_path
    fill_in 'login-email', with: user.email
    fill_in 'login-password', with: 'foobar'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'

    # 自分の商品の場合は編集ページが存在する
    visit product_path(product.id)
    expect(page).to have_content '編集する'
    click_link '編集する'

    # 商品の編集
    # 無効な編集
    expect(page).to have_content '商品の編集'
    fill_in '商品名', with: ''
    fill_in '商品紹介', with: ''
    fill_in '原材料', with: ''
    select '野菜or果物', from: 'カテゴリー'
    fill_in '価格', with: ''
    fill_in '消費期限', with: ''
    fill_in '総重量', with: ''
    click_button '更新する'
    expect(page).to have_content '商品の編集'
    expect(page).to have_content 'エラーが8個あります。'

    visit product_path(product.id)
    click_link '編集する'

    # 有効な編集
    attach_file 'product[product_avatars][]', 'spec/system/test3.jpg'
    fill_in '商品名', with: 'Test-Product2'
    fill_in '商品紹介', with: 'hogehogefoobar2'
    fill_in '原材料', with: 'foobar2'
    select 'お肉', from: 'カテゴリー'
    fill_in '価格', with: '4321'
    fill_in '消費期限', with: '002024-12-31'
    fill_in '総重量', with: '2.5'
    click_button '更新する'
    expect(page).to have_content '商品の編集が完了しました。'

    # 商品の削除
    visit product_path(product.id)
    click_link '編集する'
    expect { click_link '商品を削除する' }.to change { Product.all.size }.by(-1)
  end
end
