class BookFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity
    @service = BooksService.new
  end

  def book_search
    books_info = @service.book_search(@location, @quantity)
    books_info[:docs].map do |book_data|
      Book.new(book_data)
    end
  end

  def total_book_count
    books_info = @service.book_search(@location, @quantity)
    total_books = books_info[:numFound]
  end
end