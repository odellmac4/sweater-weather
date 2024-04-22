class Forecast
  attr_reader :id, 
              :current_weather, 
              :daily_weather, 
              :hourly_weather, 
              :location
  def initialize(forecast_data)
    @id = nil
    @location = forecast_data[:location][:name]
    @current_weather = extract_current_weather(forecast_data)
    @daily_weather = extract_daily_weather(forecast_data)
    @hourly_weather = extract_hourly_weather(forecast_data)
  end

  def extract_current_weather(forecast_data)
    current_forecast = forecast_data[:current]
    current_weather = {
      last_updated: current_forecast[:last_updated],
      temperature: current_forecast[:temp_f],
      feels_like: current_forecast[:feelslike_f],
      humidity: current_forecast[:humidity],
      uvi: current_forecast[:uv],
      visibility: current_forecast[:vis_miles],
      condition: current_forecast[:condition][:text],
      icon: current_forecast[:condition][:icon]
    }
  end

  def extract_daily_weather(forecast_data)
    five_day_forecast = forecast_data[:forecast][:forecastday]
    daily_weather = five_day_forecast.map do |day|
      daily_forecast = {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def extract_hourly_weather(forecast_data)
    five_day_forecast = forecast_data[:forecast][:forecastday]
    hourly_weather = five_day_forecast.map do |day|
      day[:hour].map do |hour|
        hourly_forecast = {
          time: hour[:time],
          temperature: hour[:temp_f],
          condition: hour[:condition][:text].strip,
          icon: hour[:condition][:icon]
        }
      end
    end
    hourly_weather.first
  end
end