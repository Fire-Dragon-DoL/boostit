# frozen_string_literal: true

require 'test_helper'

class AuthenticatedTest < IntegrationCase
  test 'When getting current integer, success' do
    user = User::Sample.random
    user.save!
    sign_in user

    get current_serial_url, headers: jsonapi_headers

    assert @response.status >= 200 && @response.status <= 299
  end
end
