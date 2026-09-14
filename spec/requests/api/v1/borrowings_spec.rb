require 'rails_helper'

RSpec.describe 'Api::V1::Borrowings', type: :request do
  let(:book) { create(:book) }
  let(:reader) { create(:reader) }

  describe 'POST /api/v1/borrowings/checkout' do
    context 'with valid parameters' do
      let(:valid_params) { { book_id: book.id, reader_id: reader.id } }

      it 'successfully checks out the book' do
        post checkout_api_v1_borrowings_path,
             params: valid_params.to_json,
             headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['book_id']).to eq(book.id)
        expect(json['reader_id']).to eq(reader.id)
        expect(json['return_date']).to be_nil
      end
    end

    context 'when the book is already borrowed' do
      before { create(:borrowing, book: book, reader: reader, return_date: nil) }

      it 'returns an unprocessable entity status' do
        post checkout_api_v1_borrowings_path,
             params: { book_id: book.id, reader_id: reader.id }.to_json,
             headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_content)
        json = JSON.parse(response.body)
        expect(json['error']).to eq('Book is already borrowed')
      end
    end
  end

  describe 'PATCH /api/v1/borrowings/return' do
    context 'when the book is currently borrowed' do
      let!(:borrowing) { create(:borrowing, book: book, reader: reader, return_date: nil) }

      it 'successfully returns the book' do
        patch return_api_v1_borrowings_path,
              params: { book_id: book.id }.to_json,
              headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['return_date']).not_to be_nil
      end
    end

    context 'when the book is not currently borrowed' do
      it 'returns an unprocessable entity status' do
        patch return_api_v1_borrowings_path,
              params: { book_id: book.id }.to_json,
              headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to have_http_status(:unprocessable_content)
        json = JSON.parse(response.body)
        expect(json['error']).to eq('Book is not currently borrowed')
      end
    end
  end
end
