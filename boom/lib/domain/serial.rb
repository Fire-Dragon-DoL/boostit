# frozen_string_literal: true

module Domain
  module Serial
    def self.min
      0
    end

    def self.max
      9_223_372_036_854_775_807
    end

    module Sample
      def self.random
        rand(Serial.min..Serial.max)
      end

      def self.one
        1
      end

      def self.two
        2
      end
    end
  end
end
