FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    packing_type { :piece }

    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2) }
    active { true }
  end
end