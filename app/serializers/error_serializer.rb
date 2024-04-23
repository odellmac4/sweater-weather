class ErrorSerializer
  def initialize(message, status)
    @message = message
    @status = status
  end

  def serialize_invalidation
    {
      errors: [
        {
          detail: @message
        }
      ]
    }
  end
end