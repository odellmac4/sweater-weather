class Book
  attr_reader :title, :isbn, :publisher

  def initialize(book_data)
    @title = book_data[:title]
    @isbn = book_data[:isbn]
    @publisher = book_data[:publisher]
  end
end