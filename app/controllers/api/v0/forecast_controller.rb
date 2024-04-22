class Api::V0::ForecastController < ApplicationController
  def index
    location = LocationFacade.location_specs(location_query)
    forecast = ForecastFacade.forecast_specs(location.lat, location.lng)
    render json: ForecastSerializer.new(forecast), status: :ok
  end

  private

  def location_query
    params[:location]
  end
end
