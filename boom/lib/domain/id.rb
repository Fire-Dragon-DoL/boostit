# frozen_string_literal: true

require 'securerandom'

module Domain
  module Id
    module Sample
      def self.random
        SecureRandom.uuid
      end
    end
  end
end
