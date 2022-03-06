FactoryBot.define do
  factory :larva_species do
    name        { Faker::Movies::HowToTrainYourDragon.dragon }
    description { Faker::Lorem.paragraph }

    # trait :with_larvae do
    #   after(:create) do |_larva_species|
    #     create(:larvae, larva_species: _larva_species)
    #   end
    # end
    #
    # trait :with_larvae do
    #   after(:create) do |_larva_species|
    #     create_list(:larvae, Faker::Number.within(range: 1..4), larva_species: _larva_species)
    #   end
    # end
  end
end
