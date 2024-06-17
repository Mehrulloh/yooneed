FactoryBot.define do
  factory :order do
    amount { Faker::Number.decimal(l_digits: 2) }
    association :user
    association :product
    status { :processing }

    trait :accepted do
      status { :accepted }
    end

    trait :denied do
      status { :denied }
    end
  end
end
