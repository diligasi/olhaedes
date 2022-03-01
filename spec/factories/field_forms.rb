FactoryBot.define do
  factory :field_form do
    association :user
    association :property_type

    status        { 0 }
    street        { Faker::Address.street_name }
    number        { Faker::Address.building_number }
    complement    { Faker::Address.secondary_address }
    block         { Faker::Address.country_code_long }
    district      { Faker::Address.community }
    city          { Faker::Address.city }
    state         { Faker::Address.state }
    country       { 'Brasil' }
    zipcode       { %w[24310-550 24346-210 24342-440].sample }
    visit_status  { 0 }
    visit_comment { Faker::Lorem.paragraph }
    larvae_found  { false }
    larvicide     { false }
    rodenticide   { false }

    trait :with_complete_status do
      status { 1 }
    end

    trait :with_visit_status_refused do
      visit_status { 1 }
    end

    trait :with_visit_status_closed do
      visit_status { 2 }
    end

    trait :with_larvae_found do
      larvae_found { true }
    end

    trait :with_larvicide do
      larvicide { true }
    end

    trait :with_rodenticide do
      rodenticide { true }
    end
  end
end
