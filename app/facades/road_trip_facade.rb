class RoadTripFacade
  def initialize(locations)
    @locations = locations
  end

  def directions
    final_destination = LocationFacade.location_specs(destination)
    forecast = ForecastFacade.forecast_specs(final_destination.lat, final_destination.lng)
    
    map_service = MapQuestService.new
    direction_info = map_service.directions(origin, destination)
    
    if !direction_info[:message].present?
      road_trip = RoadTrip.new(direction_info, forecast)
    else
      raise_error(direction_info)
    end
  end

  def origin
    @locations[:origin]
  end

  def destination
    @locations[:destination]
  end

  def raise_error(direction_info)
    direction_info[:responseBody][:errors]
  end
end