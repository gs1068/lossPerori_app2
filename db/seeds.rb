User.create!(username:  "Example User",
             email: "example@lossperori.com",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@lossperori.com"
  password = "password"
  User.create!(username:  username,
               email: email,
               password:              password,
               password_confirmation: password)
end