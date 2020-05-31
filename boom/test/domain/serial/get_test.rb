# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'
require 'domain/serial/get'
require 'domain/serial/set'
require 'domain/id'

module Domain
  module Serial
    class GetTest < ActiveSupport::TestCase
      test 'With unknown id, returns 0' do
        id = Id::Sample.random

        result = Serial::Get.(id)

        assert result == 0
      end

      test 'With id with value set, returns current value' do
        id = Id::Sample.random
        value = Serial.random

        Serial::Set.(id, value)
        result = Serial::Get.(id)

        assert result == value
      end

      test 'With different ids, returns current value' do
        id = Id::Sample.random
        other_id = Id::Sample.random
        value = Serial.one
        other_value = Serial.two

        Serial::Set.(id, value)
        Serial::Set.(other_id, other_value)
        result = Serial::Get.(id)
        other_result = Serial::Get.(other_id)

        assert result != other_result
        assert result == value
        assert other_result == other_value
      end
    end
  end
end
