# frozen_string_literal: true

module DB
  KVStorage = Redis::Namespace.new('boom:kvstorage', redis: Redis.new)
end
