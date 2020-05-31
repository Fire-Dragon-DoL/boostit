module Domain
  module Serial
    class Set
      def call(id, value)
        ::DB::KVStorage.set(id, value.to_s)
      end

      def self.call(id, value)
        instance = new
        instance.(id, value)
      end
    end
  end
end
