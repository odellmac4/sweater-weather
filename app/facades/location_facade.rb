class LocationFacade

  def self.location_specs(location)
    service = MapQuestService.new
    location_data = service.location_specs(location)
    Location.new(location_data)
  end
  
end