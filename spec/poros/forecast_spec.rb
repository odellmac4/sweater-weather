require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    @forecast = Forecast.new(TestData.forecast_data)
  end

  it '#extract_current_weather' do
    current_forecast = @forecast.current_weather
    expect(current_forecast).to be_a Hash
    expect(current_forecast).to have_key(:last_updated)
    expect(current_forecast[:last_updated]).to eq("2024-04-22 07:15")
    expect(current_forecast).to have_key(:temperature)
    expect(current_forecast[:temperature]).to eq(39.2)
    expect(current_forecast).to have_key(:feels_like)
    expect(current_forecast[:feels_like]).to eq(33.5)
    expect(current_forecast).to have_key(:humidity)
    expect(current_forecast[:humidity]).to eq(87)
    expect(current_forecast).to have_key(:uvi)
    expect(current_forecast[:uvi]).to eq(2.0)
    expect(current_forecast).to have_key(:visibility)
    expect(current_forecast[:visibility]).to eq(6.0)
    expect(current_forecast).to have_key(:condition)
    expect(current_forecast[:condition]).to eq("Partly cloudy")
    expect(current_forecast).to have_key(:icon)
    expect(current_forecast[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")
  end

  it '#extract_daily_weather' do
    daily_forecast = @forecast.daily_weather
    expect(daily_forecast).to be_an Array
    expect(daily_forecast.count).to eq(5)
    
    forecast = daily_forecast.first

    expect(forecast[:date]).to eq("2024-04-22")
    expect(forecast[:sunrise]).to eq("06:46 AM")
    expect(forecast[:sunset]).to eq("08:53 PM")
    expect(forecast[:max_temp]).to eq(52.4)
    expect(forecast[:min_temp]).to eq(36.8)
    expect(forecast[:condition]).to eq("Patchy rain nearby")
    expect(forecast[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/176.png")
  end

  it '#extract_hourly_weather' do
    hourly_forecast = @forecast.hourly_weather
    expect(hourly_forecast).to be_an Array
    expect(hourly_forecast.count).to eq(24)

    hour = hourly_forecast.first

    expect(hour[:time]).to eq("2024-04-22 00:00")
    expect(hour[:temperature]).to eq(40.5)
    expect(hour[:condition]).to eq("Clear")
    expect(hour[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")
  end

  it 'exists' do
    expect(@forecast).to be_a Forecast
  end
end