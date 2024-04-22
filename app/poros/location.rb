class Location
  attr_reader :lat, :lng
  def initialize(location_data)
    @lat = location_data[:results].first[:locations].first[:latLng][:lat]
    @lng = location_data[:results].first[:locations].first[:latLng][:lng]
  end
end