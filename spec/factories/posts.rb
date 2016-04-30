FactoryGirl.define do
  factory :post do
    name { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    category
  end
end
