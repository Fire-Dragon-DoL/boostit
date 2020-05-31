# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'

module Current
  class DifferentUsersTest < IntegrationCase
    test 'When getting current integer of different users, number differs' do
      user = register_and_sign_in
      value = ::Domain::Serial::Sample.two
      put reset_serial_url, params: { current: value }
      assert @response.status == 200

      other_user = register_and_sign_in
      other_value = ::Domain::Serial::Sample.one
      put reset_serial_url, params: { current: other_value }
      assert @response.status == 200

      sign_in(user)
      get current_serial_url
      result = parsed_body['current']
      sign_in(other_user)
      get current_serial_url
      other_result = parsed_body['current']

      assert result != other_result
      assert result == value
      assert other_result == other_value
    end
  end
end
