Borrowing.destroy_all
Book.destroy_all
Reader.destroy_all

puts "Creating readers..."
readers = 5.times.map do |i|
  Reader.create!(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    card_number: Faker::Number.unique.number(digits: 6).to_s
  )
end

puts "Creating books..."
books = 5.times.map do |i|
  Book.create!(
    title: Faker::Book.unique.title,
    author: Faker::Book.author,
    serial_number: Faker::Alphanumeric.unique.alphanumeric(number: 6).upcase
  )
end

puts "Done! Created #{readers.count} readers and #{books.count} books."
