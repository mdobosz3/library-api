require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with all required attributes' do
    book = build(:book)
    expect(book).to be_valid
  end

  it 'is invalid without a 6-digit serial number' do
    book = build(:book, serial_number: '123')
    expect(book).not_to be_valid
  end
end
