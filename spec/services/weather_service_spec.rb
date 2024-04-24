require 'rails_helper'

RSpec.describe WeatherService, :vcr do
    before(:each) do
      @service = WeatherService.new
    end

    it 'exists' do
      expect(@service).to be_a WeatherService
    end

    it 'establishes a connection' do
      expect(@service.conn).to be_a Faraday::Connection
    end

    it 'retrieves forecast based off of lat and lng' do
      VCR.use_cassette("forecast_by_lat_lng", record: :new_episodes) do
        forecast = @service.forecast(48.8567, 2.3508)
        expect(forecast).to be_a Hash

        expect(forecast).to have_key(:current)
        expect(forecast[:current]).to be_a Hash
        expect(forecast[:current]).to have_key(:last_updated)
        expect(forecast[:current]).to have_key(:temp_f)
        expect(forecast[:current]).to have_key(:feelslike_f)
        expect(forecast[:current]).to have_key(:humidity)
        expect(forecast[:current]).to have_key(:uv)
        expect(forecast[:current]).to have_key(:vis_miles)
        expect(forecast[:current]).to have_key(:condition)
        expect(forecast[:current][:condition]).to have_key(:text)
        expect(forecast[:current][:condition]).to have_key(:icon)

        expect(forecast[:forecast][:forecastday].count).to eq(5)
        forecast[:forecast][:forecastday].map do |day|
        expect(day).to have_key(:date)
        expect(day[:day][:maxtemp_f]).to be_a Float
        expect(day[:day][:mintemp_f]).to be_a Float
        expect(day[:day][:condition]).to be_a Hash
        expect(day[:day][:condition]).to have_key(:text)
        expect(day[:day][:condition]).to have_key(:icon)

        expect(day[:astro]).to be_a Hash
        expect(day[:astro]).to have_key (:sunrise)
        expect(day[:astro]).to have_key (:sunset)

        expect(day[:hour]).to be_an Array
        expect(day[:hour].count).to eq(24)

        hour = day[:hour].first

        expect(hour).to be_a Hash
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temp_f)
        expect(hour[:temp_f]).to be_a Float
        expect(hour).to have_key(:condition)
        expect(hour[:condition]).to have_key(:text)
        expect(hour[:condition]).to have_key(:icon)
      end
    end
  end
end