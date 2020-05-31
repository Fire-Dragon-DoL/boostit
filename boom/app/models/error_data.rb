class ErrorData
  attr_accessor :exception

  def initialize(exception)
    @exception = exception
  end

  def title
    exception.class.name.to_s
  end

  def detail
    exception.message.to_s
  end
end
