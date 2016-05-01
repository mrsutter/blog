FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :with_comments do
      after(:create) do |user|
        5.times do
          create(:comment, user: user)
        end
      end
    end
  end
end
