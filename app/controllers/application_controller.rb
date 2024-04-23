class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def invalid_response(exception)
    render json: ErrorSerializer.new(exception)
      .serialize_invalidation, status: :bad_request
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(exception)
      .serialize_not_found, status: 404
  end
end
