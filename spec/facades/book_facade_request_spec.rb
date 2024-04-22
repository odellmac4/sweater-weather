require 'rails_helper'

RSpec.describe BookFacade, :vcr do
  before(:each) do
    @facade = BookFacade.new("denver,co", 5)
    
  end

  it 'exists' do
    expect(@facade).to be_a BookFacade
  end

  it 'creates book poros from response' do
    expect(@facade.book_search).to be_an Array
    expect(@facade.book_search.first).to be_a Book
  end

  it '#total_book_count' do
    expect(@facade.total_book_count).to be_a Integer
  end
end