require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  it 'retrieves forecast specs and make a forecast poro' do
    forecast_specs = ForecastFacade.forecast_specs(48.8567, 2.3508)
    expect(forecast_specs).to be_a Forecast
  end
end