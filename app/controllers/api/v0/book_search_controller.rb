class Api::V0::BookSearchController < ApplicationController
  def index
    location = LocationFacade.location_specs(location_query)
    forecast = ForecastFacade.forecast_specs(location.lat, location.lng)
    facade = BookFacade.new(forecast.location, quantity)
    render json: BookSearchSerializer.new(facade, forecast).serialize_json, status: :ok
  end

  private

  def location_query
    params[:location]
  end

  def quantity
    params[:quantity]
  end
end