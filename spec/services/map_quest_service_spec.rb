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

  it 'retrieves location specs' do
    response = @service.location_specs("cincinatti,oh")
    binding.pry
    expect(response).to be_a Hash
    expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
    expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
  end
end