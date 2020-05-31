module Domain
  module Serial
    class Get
      def call(id)
        ::DB::KVStorage.get(id)&.to_i || 0
      end

      def self.call(id)
        instance = new
        instance.(id)
      end
    end
  end
end
