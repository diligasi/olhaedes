FactoryBot.define do
  factory :faq do
    question { Faker::Lorem.question }
    answer   { Faker::Lorem.paragraph }
  end
end
