class ErrorSerializer
  def initialize(exception)
    @exception = exception
  end

  def serialize_invalidation
    {
      errors: [
        {
          detail: @exception.message
        }
      ]
    }
  end

  def serialize_not_found
    {
      errors: [
        {
          detail: "Couldn't find User with email: #{@exception.id[:email]} and password: #{@exception.id[:password]}"
        }
      ]
    }
  end
end