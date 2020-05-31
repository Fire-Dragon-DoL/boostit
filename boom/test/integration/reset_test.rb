# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'

class ResetTest < IntegrationCase
  test 'Sets current integer for user' do
    value = ::Domain::Serial::Sample.two

    user = register_and_sign_in
    get current_serial_url, headers: jsonapi_headers
    prior_value = parsed_body['data']['attributes']['current']

    sign_in(user)
    put reset_serial_url, params: { current: value }.to_json, headers: jsonapi_headers

    sign_in(user)
    get current_serial_url, headers: jsonapi_headers
    new_value = parsed_body['data']['attributes']['current']

    assert prior_value == ::Domain::Serial.min
    assert new_value == value
  end

  test 'Unprocessable if set to a non-integer' do
    value = ::Domain::Serial::Sample.invalid

    register_and_sign_in
    put reset_serial_url, params: { current: value }.to_json, headers: jsonapi_headers

    assert @response.status == 403
  end

  test 'Unprocessable if set below minimum' do
    value = ::Domain::Serial.min - 1

    register_and_sign_in
    put reset_serial_url, params: { current: value }.to_json, headers: jsonapi_headers

    assert @response.status == 403
  end

  test 'Unprocessable if set above maximum' do
    value = ::Domain::Serial.max + 1

    register_and_sign_in
    put reset_serial_url, params: { current: value }.to_json, headers: jsonapi_headers

    assert @response.status == 403
  end
end
