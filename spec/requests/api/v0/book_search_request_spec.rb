require 'rails_helper'

RSpec.describe 'Book search request', :vcr do
  describe 'final endpoint' do
    it 'returns 5 books about a location based on a location query along with weather specs' do
      get '/api/v0/book-search?location=denver,co&quantity=5'

      expect(response).to be_successful

      search_response = JSON.parse(response.body, symbolize_names: true)
      search = search_response[:data]

      expect(search).to have_key(:id)
      expect(search[:type]).to eq("books")
      expect(search).to have_key(:attributes)
      expect(search[:attributes]).to have_key(:destination)
      expect(search[:attributes]).to have_key(:total_books_found)
      expect(search[:attributes]).to have_key(:forecast)
      expect(search[:attributes]).to have_key(:books)
      expect(search[:attributes][:books]).to be_an Array
      expect(search[:attributes][:forecast]).to be_a Hash
      expect(search[:attributes][:forecast]).to have_key(:summary)
      expect(search[:attributes][:forecast]).to have_key(:temperature)
    end
  end
end