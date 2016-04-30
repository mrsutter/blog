FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.word }

    trait :with_post do
      after(:create) do |category|
        create(:post, category: category)
      end
    end

    trait :with_posts do
      after(:create) do |category|
        5.times do
          create(:post, category: category)
        end
      end
    end
  end
end
