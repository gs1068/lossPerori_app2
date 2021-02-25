FactoryBot.define do
  factory :product do
    product_name { "TestUser1" }
    product_intro { "password" }
    raw_material { "password" }
    categories { "野菜&果物" }
    fee { 1232 }
    expiration_date { Time.current.since(3.days) }
    total_weight { 12 }
    created_at { 10.minutes.ago }
    product_avatars { [Rack::Test::UploadedFile.new(Rails.root.join('spec/system/test.jpg'), 'spec/system/test.jpg')] }

    trait :yesterday do
      product_name { "TestUser2" }
      expiration_date { Time.current.since(10.days) }
      product_intro { "yesterday" }
      categories { "お肉" }
      fee { 4322 }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      product_name { "TestUser3" }
      expiration_date { Time.current.since(20.days) }
      product_intro { "day_before_yesterday" }
      categories { "海鮮" }
      fee { 543 }
      created_at { 2.day.ago }
    end

    trait :now do
      product_name { "TestUser4" }
      expiration_date { Time.current.since(30.days) }
      product_intro { "now" }
      categories { "お菓子" }
      fee { 876 }
      created_at { Time.zone.now }
    end

    trait :other_user_product do
      product_name { "TestUser4" }
      expiration_date { Time.current.since(30.days) }
      product_intro { "now" }
      categories { "お菓子" }
      fee { 876 }
      created_at { 3.day.ago }
    end
  end
end
