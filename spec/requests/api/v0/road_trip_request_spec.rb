require 'rails_helper'

RSpec.describe 'Road trip request', :vcr do
  describe 'endpoint 4' do
    before(:each) do
      user_params = {
        "email": "keoki@dog.com",
        "password": "keoki1",
        "password_confirmation": "keoki1"
      }

      post '/api/v0/users', params: user_params.to_json, headers: { 'Content-Type' => 'application/json' }
    end
  
    it 'returns road trip specs' do
      VCR.use_cassette("Road_trip_request/is_a_roadtrip", record: :new_episodes) do
        road_trip_params = {
          "origin": "Cincinatti,OH",
          "destination": "Chicago,IL",
          "api_key": User.all.last.api_key
        }

        
        post '/api/v0/road_trip', params: road_trip_params.to_json, headers: { 'Content-Type' => 'application/json' }

        expect(response).to be_successful

        road_trip_response = JSON.parse(response.body, symbolize_names: true)
        expect(road_trip_response).to be_a Hash
        expect(road_trip_response[:data]).to have_key(:id)
        expect(road_trip_response[:data]).to have_key(:type)
        expect(road_trip_response[:data][:type]).to eq('road_trip')
        expect(road_trip_response[:data]).to have_key(:attributes)
        expect(road_trip_response[:data][:attributes]).to have_key(:start_city)
        expect(road_trip_response[:data][:attributes]).to have_key(:end_city)
        expect(road_trip_response[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip_response[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
        expect(road_trip_response[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      end
    end

    it 'returns an error when no directions' do
      VCR.use_cassette("Road_trip_request/is_an_error", record: :new_episodes) do
        road_trip_params = {
          "origin": "New York, NY",
          "destination": "London, UK",
          "api_key": User.all.last.api_key
        }

        
        post '/api/v0/road_trip', params: road_trip_params.to_json, headers: { 'Content-Type' => 'application/json' }

        expect(response).to_not be_successful
        road_trip_response = JSON.parse(response.body, symbolize_names: true)
        expect(road_trip_response).to be_an Hash
        expect(road_trip_response).to have_key (:errors)
        expect(road_trip_response[:errors].first).to have_key (:detail)
        expect(road_trip_response[:errors].first[:detail]).to be_an (Array)
        expect(road_trip_response[:errors].first[:detail].first).to be_a (String)
      end
    end
  end
end