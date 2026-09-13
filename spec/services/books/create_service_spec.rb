require 'rails_helper'

RSpec.describe Books::CreateService do
  describe '#call' do
    let(:valid_params) { { title: 'The Hobbit', author: 'J.R.R. Tolkien' } }

    it 'creates a new book with a generated 6-digit serial number' do
      result = nil
      
      expect {
        result = described_class.new.call(valid_params)
      }.to change(Book, :count).by(1)

      expect(result[:success]).to be true
      expect(result[:book].title).to eq('The Hobbit')
      expect(result[:book].serial_number.length).to eq(6)
    end

    it 'returns errors when params are invalid' do
      result = nil
      
      expect {
        result = described_class.new.call({ title: '' })
      }.not_to change(Book, :count)

      expect(result[:success]).to be false
      expect(result[:errors]).to include("Author can't be blank")
    end
  end
end
