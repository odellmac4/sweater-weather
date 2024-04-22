require 'rails_helper'

RSpec.describe 'Weather and city response', :vcr do
  describe 'endpoint 1' do
    it 'retrieves weather for a city' do
      get '/api/v0/forecast?location=cincinatti,oh'
    
    expect(response).to be_successful

    forecast_response = JSON.parse(response.body, symbolize_names: true)
    forecast = forecast_response[:data]

    expect(forecast).to have_key(:id)
    expect(forecast[:id]).to eq nil
    expect(forecast).to have_key(:type)
    expect(forecast[:type]).to eq "forecast"
    expect(forecast).to have_key(:attributes)
    expect(forecast[:attributes]).to be_a Hash
    expect(forecast[:attributes]).to have_key(:current_weather)
    expect(forecast[:attributes][:current_weather]).to be_a Hash
    expect(forecast[:attributes][:current_weather]).to have_key(:last_updated)
    expect(forecast[:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast[:attributes]).to have_key(:daily_weather)
    expect(forecast[:attributes][:daily_weather]).to be_an Array
    expect(forecast[:attributes][:daily_weather].first).to be_a Hash
    expect(forecast[:attributes][:daily_weather].first).to have_key(:date)
    expect(forecast[:attributes][:daily_weather].first).to have_key(:sunrise)
    expect(forecast[:attributes][:hourly_weather]).to be_an Array
    expect(forecast[:attributes][:hourly_weather].first).to be_a Hash
    expect(forecast[:attributes][:hourly_weather].first).to have_key(:time)
    expect(forecast[:attributes][:daily_weather].first).to have_key(:temperature)
    end
  end
end