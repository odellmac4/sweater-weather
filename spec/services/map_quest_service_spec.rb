require 'rails_helper'

RSpec.describe MapQuestService, :vcr do
  before(:each) do
    @service = MapQuestService.new
  end
  
  it 'exists' do
    expect(@service).to be_a MapQuestService
  end
  
  it 'establishes a connection' do
    expect(@service.conn).to be_a Faraday::Connection
  end

  it 'retrieves location specs'  do
    VCR.use_cassette("MapQuest/retrieve_location_specs", record: :new_episodes) do
      response = @service.location_specs("cincinatti,oh")
      expect(response).to be_a Hash
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
    end
  end

  it 'retrieves directions from a given start and end city'  do
    VCR.use_cassette("MapQuest/retrieve_directions", record: :new_episodes) do
      response = @service.directions("New York, NY", "Chicago, IL")
      expect(response).to be_a Hash
      expect(response[:route]).to have_key(:formattedTime)
      expect(response[:route][:locations]).to be_an Array
      expect(response[:route][:locations].first[:adminArea5]).to eq "New York"
      expect(response[:route][:locations].first[:adminArea3]).to eq "NY"
    end
  end
end