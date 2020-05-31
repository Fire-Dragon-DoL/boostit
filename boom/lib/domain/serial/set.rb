module Domain
  module Serial
    class Set
      def call(id, value)
        raise RangeError, "Value is below minimum" if value < Serial.min
        raise RangeError, "Value is above maximum" if value > Serial.max

        ::DB::KVStorage.set(id.to_s, value.to_s)

        value
      end

      def self.call(id, value)
        instance = new
        instance.(id, value)
      end
    end
  end
end
