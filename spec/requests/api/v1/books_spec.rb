require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  describe 'GET /api/v1/books' do
    let!(:book) { create(:book) }

    it 'returns a successful response with books data' do
      get '/api/v1/books.json', headers: { 'Accept' => 'application/json' }
      
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response).to be_an(Array)
      expect(json_response.first['title']).to eq(book.title)
      expect(json_response.first['serial_number']).to eq(book.serial_number)
    end
  end

describe 'POST /api/v1/books' do
  let(:valid_attributes) { { book: { title: 'Dune', author: 'Frank Herbert' } } }

  it 'creates a new Book and returns status created' do
    post '/api/v1/books',
         params: valid_attributes.to_json,
         headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

    expect(response).to have_http_status(:created)
    
    json_response = JSON.parse(response.body)
    expect(json_response['title']).to eq('Dune')
    expect(json_response['serial_number'].length).to eq(6)
  end
end

describe 'GET /api/v1/books/:id' do
  let(:book) { create(:book) }
  let(:reader) { create(:reader) }
  let!(:borrowing) { create(:borrowing, book: book, reader: reader, borrow_date: 10.days.ago, return_date: 5.days.ago) }

  it 'returns book details with borrowings history' do
    get api_v1_book_path(book), headers: { 'Accept' => 'application/json' }

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)

    expect(json['id']).to eq(book.id)
    expect(json['title']).to eq(book.title)
    expect(json['serial_number']).to eq(book.serial_number)
    
    expect(json['borrowings'].length).to eq(1)
    expect(json['borrowings'].first['id']).to eq(borrowing.id)
    expect(json['borrowings'].first['reader']['full_name']).to eq(reader.full_name)
  end

  it 'returns not found error when book does not exist' do
    get '/api/v1/books/999999', headers: { 'Accept' => 'application/json' }

    expect(response).to have_http_status(:not_found)
    json = JSON.parse(response.body)
    expect(json['error']).to eq('Book not found')
  end
end
end
