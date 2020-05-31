module Domain
  module Serial
    class Increment
      RedisOverflowMessage = "ERR increment or decrement would overflow"

      def call(id)
        ::DB::KVStorage.incr(id.to_s)
      rescue Redis::CommandError => err
        if err.message == RedisOverflowMessage
          raise RangeError, "Increasing would overflow"
        end

        raise err
      end

      def self.call(id)
        instance = new
        instance.(id)
      end
    end
  end
end
