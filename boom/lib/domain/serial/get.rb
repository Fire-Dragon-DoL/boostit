# frozen_string_literal: true

require 'domain/serial'

module Domain
  module Serial
    class Get
      def call(id)
        value = ::DB::KVStorage.get(id.to_s)

        return Serial.min if value.nil?

        value.to_i
      end

      def self.call(id)
        instance = new
        instance.(id)
      end
    end
  end
end
