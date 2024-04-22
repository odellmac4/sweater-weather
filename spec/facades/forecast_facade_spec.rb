require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  before(:each) do
    @facade = ForecastFacade.new
    @forecast_specs = ForecastFacade.forecast_specs(48.8567, 2.3508)
  end

  it 'exists' do
    expect(@facade).to be_a ForecastFacade
  end

  it 'retrieves forecast specs and make a forecast poro' do
    expect(@forecast_specs).to be_a Forecast
  end
end