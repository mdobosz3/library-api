require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:book) { Book.create!(serial_number: '111222', title: 'Test Book', author: 'Test Author') }
  let(:reader) { Reader.create!(card_number: '333444', full_name: 'Test Reader', email: 'test@example.com') }

  it 'prevents borrowing a book that is already checked out' do
    Borrowing.create!(book: book, reader: reader, borrow_date: Date.current)
    
    second_borrowing = Borrowing.new(book: book, reader: reader, borrow_date: Date.current)
    
    expect(second_borrowing).not_to be_valid
    expect(second_borrowing.errors[:book]).to include('is already borrowed')
  end
end
