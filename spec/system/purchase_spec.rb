RSpec.describe 'Purchase', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario 'ユーザー設定' do
    # 登録成功
    other_user_register

    # メール情報取得/ユーザー認証
    other_user_mail_info_first_login

    # ユーザーページに移動
    find(".icon-box").click
    click_link "設定"
    expect(page).to have_content 'こんにちはOther_Userさん'
    expect(page).to have_content 'アカウント'
    click_link 'アカウントを編集する'

    # アカウント編集ページに移動
    # オプションの設定
    other_user_advanced_setting

    # 有効な商品の出品
    listing

    # ログアウト
    logout

    # 購入ユーザー作成
    register

    # メール情報取得/ユーザー認証
    mail_info_first_login

    # ユーザーページに移動
    find(".icon-box").click
    click_link "設定"
    expect(page).to have_content 'こんにちはTest_Userさん'
    expect(page).to have_content 'アカウント'
    click_link 'アカウントを編集する'

    # アカウント編集ページに移動
    # オプションの設定
    advanced_setting

    # 購入
    product = Product.first
    visit product_path(product.id)
    login
    click_button '購入へ進む'
    expect(current_url).to match confirm_purchases_path
    click_button '注文内容を確定する'
    expect(current_url).to match thanks_purchases_path
    expect(page).to have_content '注文を確定しました'
  end
end
