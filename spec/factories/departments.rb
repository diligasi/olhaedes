FactoryBot.define do
  factory :department do
    name        { Faker::Commerce.department }
    description { Faker::Lorem.paragraph }

    trait :with_region do
      after(:create) do |_department|
        create(:region, department: _department)
      end
    end

    trait :with_regions do
      after(:create) do |_department|
        create_list(:region, Faker::Number.within(range: 1..10), :with_users, department: _department)
      end
    end
  end
end
