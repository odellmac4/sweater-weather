class MapQuestService
  def directions(origin, destination)
    json_payload = {
      locations: [origin, destination]
    }.to_json

    get_url("/directions/v2/optimizedroute?json=#{json_payload}")
  end
  
  def location_specs(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.map_quest[:key]
    end
  end
end