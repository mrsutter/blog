FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    post
  end
end
