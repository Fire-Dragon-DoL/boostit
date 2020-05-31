# frozen_string_literal: true

require 'test_helper'
require 'domain/serial'

class NextTest < IntegrationCase
  test 'Increases integer for user' do
    user = register_and_sign_in
    get next_serial_url
    prior_value = parsed_body['data']['attributes']['current']

    sign_in(user)
    get next_serial_url
    new_value = parsed_body['data']['attributes']['current']

    assert prior_value == ::Domain::Serial.min + 1
    assert new_value == prior_value + 1
  end

  test 'Bad request if current value is maximum' do
    value = ::Domain::Serial.max

    user = register_and_sign_in
    put reset_serial_url, params: { current: value }

    sign_in(user)
    get next_serial_url

    assert @response.status == 400
  end
end
