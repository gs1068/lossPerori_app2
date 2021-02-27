## アプリケーション：ロスペロリの概要

- 食品ロスをゼロにするを目的とした食品専用の EC サイト

- テストユーザー(管理権限あり)
  - email: lossperori@gmail.com
  - PW: foobar

## サイト URL

- https://dry-dusk-76134.herokuapp.com/lossperori

## アプリケーションのインフラ/機能一覧

#### インフラ

- 開発環境：Docker
- 開発言語：Ruby, jQuery, JavaScript, HTML, SCSS
- フレームワーク：Ruby on Rails
- CI/CD：CircleCI, action: Rspec, rubocop, Heroku デプロイ
- テスティングフレームワーク: Rspec
- デプロイ先:Heroku
- Github: リポジトリ,Pull Request,issue 管理
  - https://github.com/gs1068/lossPerori_app2

#### 機能

- ユーザー認証機能: 使用 Gem：Devise
  - Cookies Session,メール認証, パスワードリセット機能など
- マイページ
  - ユーザー情報変更、プロフィール変更, 食品ロスの削減重量の確認
- ユーザー住所自動入力機能: 使用 Gem：jp_prefecture
- 商品の CRUD 機能
- 商品検索機能
- 商品購入機能
- 購入履歴確認機能
- 画像投稿機能: 使用 Gem：Carrywave, ストレージ AWS S3
- ページネーション（Ajax）: 使用 Gem：kaminari
- お問い合わせ機能: ActionMailer
- 管理者ページ: 使用 Gem：rails_admin, cancancan
  - https://dry-dusk-76134.herokuapp.com/lossperori/admin

## ロスペロリ作成の目的

#### 年間 2,550 万トンもの食品廃棄の中で食べられるのに廃棄されている食品、いわゆる「食品ロス」が 612 万トンもあると言われています。さらに、追い打ちをかけるようにコロナウイルスによる飲食業界の経営自粛などで、「食品ロス」が拡大していると思われます。そんな状況を少しでも解決するべく、「食品ロスをゼロにする」を目的とするロスペロリを開発しました。
