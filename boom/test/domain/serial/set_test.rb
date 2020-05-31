# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'
require 'domain/serial/get'
require 'domain/serial/increment'
require 'domain/serial/set'
require 'domain/id'

module Domain
  module Serial
    class SetTest < ActiveSupport::TestCase
      test 'Returns value set' do
        id = Id::Sample.random
        value = Serial::Sample.two

        result = Serial::Set.(id, value)

        assert value == result
      end

      test 'Value can be set to maximum' do
        id = Id::Sample.random
        value = Serial.max

        result = Serial::Set.(id, value)

        assert value == result
      end

      test 'Value can be set to minimum' do
        id = Id::Sample.random
        value = Serial.min

        result = Serial::Set.(id, value)

        assert value == result
      end

      test 'Raises when value set above maximum' do
        id = Id::Sample.random
        value = Serial.max + 1

        assert_raise RangeError do
          Serial::Set.(id, value)
        end
      end

      test 'Raises when value is set below minimum' do
        id = Id::Sample.random
        value = Serial.min - 1

        assert_raise RangeError do
          Serial::Set.(id, value)
        end
      end
    end
  end
end
