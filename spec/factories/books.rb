FactoryBot.define do
  factory :book do
    sequence(:serial_number) { |n| n.to_s.rjust(6, '0') }
    title { Faker::Book.title }
    author { Faker::Book.author }
  end
end
