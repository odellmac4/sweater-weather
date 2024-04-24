class Api::V0::RoadTripController < ApplicationController
  def create
    roadtrip = RoadTripFacade.new(locations).directions
    user = User.find_by(api_key: road_trip_params[:api_key])
    if !user
      invalid_user
    elsif roadtrip.class != RoadTrip
      render json: ErrorSerializer.new(roadtrip)
      .serialize_invalidation, status: 404
    else
      render json: RoadTripSerializer.new(roadtrip), status: 201
    end
  end

  private 
  
  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end

  def invalid_user
    User.find(road_trip_params)
  end

  def locations
    locations_query = {
      origin: road_trip_params[:origin],
      destination: road_trip_params[:destination]
    }
  end
end