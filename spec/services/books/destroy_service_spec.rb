require 'rails_helper'

RSpec.describe Books::DestroyService do
  describe '#call' do
    let!(:book) { create(:book) }

    it 'destroys the book if it is not borrowed' do
      expect {
        described_class.new.call(book.id)
      }.to change(Book, :count).by(-1)
    end

    it 'returns an error and prevents deletion if the book has an active borrowing' do
      create(:borrowing, book: book)

      result = nil
      expect {
        result = described_class.new.call(book.id)
      }.not_to change(Book, :count)

      expect(result[:success]).to be false
      expect(result[:errors]).to include('Cannot delete a book that is currently borrowed')
    end
  end
end
