require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:book) { create(:book) }
  let(:reader) { create(:reader) }

  it 'prevents borrowing a book that is already checked out' do
    create(:borrowing, book: book, reader: reader)
    
    second_borrowing = build(:borrowing, book: book, reader: reader)
    
    expect(second_borrowing).not_to be_valid
    expect(second_borrowing.errors[:book]).to include('is already borrowed')
  end
end
