FactoryGirl.define do
  factory :post do
    name { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    category

    trait :with_comments do
      after(:create) do |post|
        5.times do
          create(:comment, post: post)
        end
      end
    end
  end
end
