FactoryBot.define do
  factory :region do
    association :department

    name { Faker::Commerce.department }

    trait :with_user do
      after(:create) do |_region|
        create(:user, region: _region)
      end
    end

    trait :with_users do
      after(:create) do |_region|
        create_list(:user, Faker::Number.within(range: 1..5), region: _region)
      end
    end
  end
end
