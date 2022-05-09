class CustomError < StandardError
  def initialize(message, exception_type = "custom")
    @exception_type = exception_type
    super(message)
  end
end
