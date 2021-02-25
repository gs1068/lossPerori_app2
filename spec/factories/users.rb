FactoryBot.define do
  factory :user do
    username { "TestUser" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    intro { "foobar" }
    
    trait :add_option do
      postcode { 1234567 }
      prefecture_code { 01 }
      address_city { "テスト区" }
      address_street { "テスト1-2-34" }
      address_building { "テスト住宅22-2" }
    end

    trait :other_user do
      username { "OtherTestUser" }
      password { "password" }
      password_confirmation { "password" }
      intro { "otheruser" }
    end
  end
end
