require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  it 'retrieves forecast specs and make a forecast poro' do
    VCR.use_cassette("ForecastFacade/make a forecast poro", record: :new_episodes) do
      forecast_specs = ForecastFacade.forecast_specs(48.8567, 2.3508)
      expect(forecast_specs).to be_a Forecast
    end
  end
end