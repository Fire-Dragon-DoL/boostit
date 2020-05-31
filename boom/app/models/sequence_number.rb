class SequenceNumber
  attr_accessor :current

  def initialize(value)
    @current = value
  end

  def id
    current
  end
end
