FactoryBot.define do
  factory :institutional do
    phone_numbers { (1..[2,3,4].sample).map { Faker::PhoneNumber.cell_phone }.join('|') }
    description   { Faker::Lorem.paragraph }
  end
end
