require 'rails_helper'

RSpec.describe RoadTripFacade, :vcr do
  before(:each) do
    locations = {:origin=>"Cincinatti,OH", :destination=>"Chicago,IL"}
    @facade = RoadTripFacade.new(locations)
  end
  it 'exists' do
    expect(@facade).to be_a RoadTripFacade
  end

  it '#directions' do
    VCR.use_cassette("converts_directions_to_road_trip", record: :new_episodes) do
      expect(@facade.directions).to be_a RoadTrip
    end
  end

  it 'returns an error when no directions available' do
    VCR.use_cassette("RoadTripFacade/return_error", record: :new_episodes) do
      locations = {:origin=>"New York, NY", :destination=>"London, UK"}
      facade = RoadTripFacade.new(locations)
      expect(facade.directions).to be_an Array
    end
  end
end