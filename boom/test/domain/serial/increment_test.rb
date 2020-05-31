# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'
require 'domain/serial/get'
require 'domain/serial/increment'
require 'domain/serial/set'
require 'domain/id'

module Domain
  module Serial
    class IncrementTest < ActiveSupport::TestCase
      test 'Value incremented by 1' do
        id = Id::Sample.random
        value = Serial::Sample.two

        Serial::Set.(id, value)
        result = Serial::Increment.(id)
        get_result = Serial::Get.(id)

        assert result == value + 1
        assert result == get_result
      end

      test 'With never set id, value is incremented by 1' do
        id = Id::Sample.random

        Serial::Increment.(id)
        result = Serial::Get.(id)

        assert result == 1
      end


      test 'Raises when value already at maximum' do
        id = Id::Sample.random
        value = Serial.max

        Serial::Set.(id, value)

        assert_raise RangeError do
          Serial::Increment.(id)
        end
      end
    end
  end
end
