# frozen_string_literal: true

require 'domain/serial'

module Serial
  class Set
    include ActiveModel::Validations

    attr_accessor :current

    validates :current,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: ::Domain::Serial.min,
                less_than_or_equal_to: ::Domain::Serial.max
              }

    def initialize(current)
      @current = current
    end

    def self.build(params)
      current = params[:current]
      current = current.to_i if current.to_i.to_s == current.to_s

      new(current)
    end
  end
end
