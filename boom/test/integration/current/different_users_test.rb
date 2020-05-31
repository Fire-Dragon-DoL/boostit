# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'

module Current
  class DifferentUsersTest < IntegrationCase
    test 'When getting current integer of different users, number differs' do
      value = ::Domain::Serial::Sample.two

      user = register_and_sign_in
      put reset_serial_url, params: { current: value }.to_json, headers: jsonapi_headers
      assert @response.status == 200

      other_value = ::Domain::Serial::Sample.one
      other_user = register_and_sign_in
      put reset_serial_url, params: { current: other_value }.to_json, headers: jsonapi_headers
      assert @response.status == 200

      sign_in(user)
      get current_serial_url, headers: jsonapi_headers
      result = parsed_body['data']['attributes']['current']

      sign_in(other_user)
      get current_serial_url, headers: jsonapi_headers
      other_result = parsed_body['data']['attributes']['current']

      assert result != other_result
      assert result == value
      assert other_result == other_value
    end
  end
end
