require 'rails_helper'

RSpec.describe Borrowings::ReturnService do
  describe '#call' do
    let(:book) { create(:book) }

    it 'updates the return date of an active borrowing' do
      borrowing = create(:borrowing, book: book, borrow_date: 5.days.ago)

      result = described_class.new.call(book_id: book.id)

      expect(result[:success]).to be true
      expect(borrowing.reload.return_date).to eq(Date.current)
    end

    it 'returns an error if the book is not currently borrowed' do
      result = described_class.new.call(book_id: book.id)

      expect(result[:success]).to be false
      expect(result[:errors]).to include('Book is not currently borrowed')
    end
  end
end
