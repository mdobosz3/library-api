require 'rails_helper'

RSpec.describe Books::WithStatusQuery do
  describe '#call' do
    let!(:available_book) { create(:book) }
    let!(:borrowed_book) { create(:book) }
    let!(:borrowing) { create(:borrowing, book: borrowed_book) }

    it 'returns all books and preloads their active borrowings' do
      result = described_class.new.call

      expect(result).to include(available_book, borrowed_book)

      loaded_borrowed_book = result.find { |b| b.id == borrowed_book.id }
      expect(loaded_borrowed_book.active_borrowing).to eq(borrowing)

      loaded_available_book = result.find { |b| b.id == available_book.id }
      expect(loaded_available_book.active_borrowing).to be_nil
    end
  end
end
