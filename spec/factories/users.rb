FactoryBot.define do
  factory :user do
    association :region

    name   { Faker::Name.unique.name }
    cpf    { Faker::CPF.number }
    status { true }
    role   { :field }

    email              { Faker::Internet.email }
    password           { '123456' }
    encrypted_password { BCrypt::Password.create(password) }

    trait :with_disabled_status do
      status { false }
    end

    trait :with_admin_role do
      role   { :admin }
      region { nil }
    end

    trait :with_supervisor_role do
      role { :supervisor }
    end

    trait :with_lab_role do
      role { :lab }
    end
  end
end
