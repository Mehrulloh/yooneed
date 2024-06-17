FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { :supervisor } # Default role, replace with valid role key

    trait :role_supervisor do
      role { :supervisor }
    end

    trait :role_customer do
      role { :customer }
    end
  end
end
