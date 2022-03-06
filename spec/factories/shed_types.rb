FactoryBot.define do
  factory :shed_type do
    name        { Faker::Address.community }
    description { Faker::Lorem.paragraph }

    # trait :with_test_tubes do
    #   after(:create) do |_shed_type|
    #     create(:test_tubes, shed_type: _shed_type)
    #   end
    # end
    #
    # trait :with_test_tubes do
    #   after(:create) do |_shed_type|
    #     create_list(:test_tubes, Faker::Number.within(range: 1..4), shed_type: _shed_type)
    #   end
    # end
  end
end
