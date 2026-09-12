require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with all required attributes' do
    book = Book.new(serial_number: '123456', title: 'Dune', author: 'Frank Herbert')
    expect(book).to be_valid
  end

  it 'is invalid without a 6-digit serial number' do
    book = Book.new(serial_number: '123', title: 'Dune', author: 'Frank Herbert')
    expect(book).not_to be_valid
  end
end
