FactoryBot.define do
  factory :test_tube do
    association :shed_type
    association :field_form

    code             { Faker::Barcode.upc_e }
    collected_amount { [*0..6].sample }
    comments         { Faker::Lorem.paragraph }
  end
end
