# frozen_string_literal: true

class SequenceNumber
  attr_accessor :id
  attr_accessor :current

  def initialize(id, value)
    @id = id
    @current = value
  end
end
