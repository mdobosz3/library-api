FactoryBot.define do
  factory :reader do
    sequence(:card_number) { |n| n.to_s.rjust(6, '0') }
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
  end
end
