require 'rails_helper'

RSpec.describe LocationFacade, :vcr do
  before(:each) do
    @facade = LocationFacade.new
    @location_specs = LocationFacade.location_specs("cincinatti,oh")
  end
  it 'exists' do
    expect(@facade).to be_a LocationFacade
  end

  it 'retrieves location specs and creates location poro' do
    expect(@location_specs).to be_a Location
  end
end