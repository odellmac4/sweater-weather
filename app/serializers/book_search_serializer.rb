class BookSearchSerializer
  def initialize(facade, forecast)
    @facade = facade
    @forecast = forecast
  end

  def serialize_json
    {
      data:{
        id: "null",
        type: "books",
        attributes: {
          destination: @forecast.location,
          forecast: {
            summary: @forecast.current_weather[:condition],
            temperature: @forecast.current_weather[:temperature]
          },
          total_books_found: @facade.total_book_count,
          books: @facade.book_search
        }
      }
    }
  end
end