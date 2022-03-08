FactoryBot.define do
  factory :larva do
    association :test_tube
    association :larva_species

    comments { Faker::Lorem.paragraph }
  end
end
