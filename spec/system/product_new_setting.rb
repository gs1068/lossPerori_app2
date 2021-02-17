RSpec.describe 'ProductNew', type: :system do
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
    fill_in '価格', with: ''
    fill_in '消費期限', with: ''
    fill_in '総重量', with: ''
    click_button '出品する'
    expect(page).to have_content '食品の出品'
    expect(page).to have_content 'エラーが9個あります。'

    # 有効な商品の出品
    click_link '食品を出品する'
    attach_file 'product[product_avatars][]', 'spec/system/test2.jpg'
    fill_in '商品名', with: 'Test-Product'
    fill_in '商品紹介', with: 'hogehogefoobar'
    fill_in '原材料', with: 'foobar'
    fill_in '価格', with: '1234'
    fill_in '消費期限', with: '002023-12-31'
    fill_in '総重量', with: '1.5'
    click_button '出品する'
    expect(page).to have_content 'ありがとうございます。商品の出品が完了しました。'

    # 商品の編集
    # user = User.first
    # product = user.products.first
    # visit edit_product_path(product.id)

    # binding.pry
  end
end
