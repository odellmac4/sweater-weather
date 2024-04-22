class WeatherService
  def forecast(lat, lng)
    get_url("/v1/forecast.json?days=5&q=#{lat},#{lng}")
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.weather[:key]
    end
  end
end