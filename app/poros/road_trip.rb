class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(direction_data, forecast)
    @id = nil
    @forecast = forecast
    @start_city = set_start_city(direction_data)
    @end_city = set_end_city(direction_data)
    @travel_time = direction_data[:route][:formattedTime]
    @weather_at_eta = set_weather
  end

  def set_start_city(direction_data)
    start_city = direction_data[:route][:locations].first
    "#{start_city[:adminArea5]}, #{start_city[:adminArea3]}"
  end

  def set_end_city(direction_data)
    end_city = direction_data[:route][:locations].last
    "#{end_city[:adminArea5]}, #{end_city[:adminArea3]}"
  end

  def set_weather
    weather_at_eta = {
      datetime: time_match[:time],
      temperature: time_match[:temperature],
      condition: time_match[:condition]
    }
  end
  
  def time_match
    time_match = @forecast.hourly_weather.min_by do |hourly_weather|
      time = Time.parse(hourly_weather[:time])
      (future_time - time).abs
    end
  end

  def future_time
    current_time = Time.now
    hours, minutes, seconds = @travel_time.split(":").map(&:to_i)
    future_time = current_time + hours.hours + minutes.minutes + seconds.seconds
  end
end