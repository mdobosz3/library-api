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

#   describe 'POST /api/v1/books' do
#     let(:valid_attributes) { { book: { title: 'Dune', author: 'Frank Herbert' } } }

#     it 'creates a new Book and returns status created' do
#       binding.pry
#       expect {
#         post '/api/v1/books', params: valid_attributes.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
#       }.to change(Book, :count).by(1)
# puts "TEST STATUS: #{response.status}"
#       puts "TEST BODY: #{response.body}"
#       expect(response).to have_http_status(:created)
      
#       # json_response = JSON.parse(response.body)
#       # expect(json_response['title']).to eq('Dune')
#       # expect(json_response['serial_number'].length).to eq(6)
#     end
#   end
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
end
