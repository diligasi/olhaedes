FactoryBot.define do
  factory :property_type do
    name        { Faker::Books::Lovecraft.unique.location }
    description { Faker::Lorem.paragraph }
  end
end
