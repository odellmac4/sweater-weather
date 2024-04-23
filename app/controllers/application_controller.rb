class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def invalid_response(exception)
    render json: ErrorSerializer.new(exception.message, 400)
      .serialize_invalidation, status: :bad_request
  end
end
