User.create!(username:  "Genta Saito",
            email: "genta.otias@gmail.com",
            password:              "foobar",
            password_confirmation: "foobar")

User.create!(username:  "管理ユーザー",
            email: "lossperori@gmail.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: "true")

45.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@lossperori.com"
  password = "password"
  User.create!(username:  username,
              email: email,
              password:              password,
              password_confirmation: password)
end

40.times do |n|
  product_name  = "【伊勢神宮奉納】特別に作られた「結び醤油」とこだわりの「かつお節」セット（送料無料）#{n+1}"
  product_intro = Faker::Lorem.sentence *10
  raw_material = Faker::Lorem.sentence
  fee = 100 + (n + 100)
  expiration_date = Time.current.since(n.days)
  total_weight = n + 1
  user_id = n + 1
  categories = "野菜or果物"
  product_avatars = [Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test3.jpg'), 'spec/system/test3.jpg'), Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test4.jpg'), 'spec/system/test4.jpg')]
  Product.create!(product_name:  product_name,
              product_intro: product_intro,
              raw_material: raw_material,
              fee: fee,
              categories: categories,
              expiration_date: expiration_date,
              total_weight: total_weight,
              user_id: user_id,
              product_avatars: product_avatars)
end