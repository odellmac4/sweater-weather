require 'rails_helper'

RSpec.describe Location do
  before(:each) do
    @location = Location.new(TestData.location_data)
  end

  it 'is a location' do
    expect(@location).to be_a Location
    expect(@location.lat).to eq(39.10713)
    expect(@location.lng).to eq(-84.50413)
  end
end