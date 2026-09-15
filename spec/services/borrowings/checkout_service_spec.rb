require 'rails_helper'

RSpec.describe Borrowings::CheckoutService do
  describe '#call' do
    let(:book) { create(:book) }
    let(:reader) { create(:reader) }

    it 'creates a borrowing record successfully' do
      result = nil
      expect {
        result = described_class.new.call(book_id: book.id, reader_id: reader.id)
      }.to change(Borrowing, :count).by(1)

      expect(result[:success]).to be true
      expect(result[:borrowing].borrow_date).to eq(Date.current)
    end

    it 'returns an error if the book is already borrowed' do
      create(:borrowing, book: book, reader: reader)

      result = described_class.new.call(book_id: book.id, reader_id: reader.id)

      expect(result[:success]).to be false
      expect(result[:errors]).to include('Book is already borrowed')
    end
  end
end
