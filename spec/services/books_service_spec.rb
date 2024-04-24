require 'rails_helper'

RSpec.describe BooksService, :vcr do
  before(:each) do
    @service = BooksService.new
  end

  it 'exists' do
    expect(@service).to be_a BooksService
  end

  it 'establishes connection' do
    expect(@service.conn).to be_a Faraday::Connection
  end

  it 'retrives 5 books' do
    VCR.use_cassette("BooksService/retrieve_5_books", record: :new_episodes) do
      book_search = @service.book_search("denver,co", 5)
      expect(book_search).to be_a Hash
      book_search[:docs].each do |book|
        expect(book).to have_key(:title)
        expect(book).to have_key(:isbn)
        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an(Array)
      end
    end
  end
end