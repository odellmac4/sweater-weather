class ForecastFacade
  def self.forecast_specs(lat, lng)
    forecast_data = WeatherService.new.forecast(lat, lng)
    Forecast.new(forecast_data)
  end
end