# frozen_string_literal: true

module Domain
  module Serial
    class Increment
      REDIS_OVERFLOW_MESSAGE = 'ERR increment or decrement would overflow'

      def call(id)
        ::DB::KVStorage.incr(id.to_s)
      rescue ::Redis::CommandError => e
        raise ::RangeError, 'Increasing would overflow' if e.message == REDIS_OVERFLOW_MESSAGE

        raise e
      end

      def self.call(id)
        instance = new
        instance.(id)
      end
    end
  end
end
