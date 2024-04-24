require 'rails_helper'

RSpec.describe RoadTrip, :vcr do
  it 'is a roadtrip' do
    VCR.use_cassette("RoadTrip/is_a_roadtrip", record: :new_episodes) do
      forecast = ForecastFacade.forecast_specs(41.88425, 87.63245)
      road_trip = RoadTrip.new(TestData.road_trip_data, forecast)

      expect(road_trip).to be_a RoadTrip
      expect(road_trip.id).to eq nil
      expect(road_trip.start_city).to eq ("Cincinnati, OH")
      expect(road_trip.end_city).to eq ("Chicago, IL")
      expect(road_trip.travel_time).to eq ("04:20:39")
      expect(road_trip.weather_at_eta).to be_a Hash
      expect(road_trip.weather_at_eta).to have_key(:datetime)
      expect(road_trip.weather_at_eta).to have_key(:temperature)
      expect(road_trip.weather_at_eta).to have_key(:condition)
    end
  end
end