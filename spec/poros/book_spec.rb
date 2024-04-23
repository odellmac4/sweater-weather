require 'rails_helper'

RSpec.describe Book do
  before(:each) do
    @book = Book.new(TestData.book_data)
  end

  it 'exists' do
    expect(@book).to be_a Book
    expect(@book.title).to eq("Denver, Co")
    expect(@book.isbn).to eq([
      "0762507845",
      "9780762507849"
      ])
    expect(@book.publisher).to eq(["Universal Map Enterprises"])
  end
end