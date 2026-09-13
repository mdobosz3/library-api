FactoryBot.define do
  factory :borrowing do
    book
    reader
    borrow_date { Date.current }
    return_date { nil }
  end
end
