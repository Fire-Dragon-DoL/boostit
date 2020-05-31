# frozen_string_literal: true

require 'test_helper'

class UnauthenticatedTest < IntegrationCase
  test 'When getting current integer, unauthorized' do
    get current_serial_url, headers: jsonapi_headers

    assert @response.status == 401
  end
end
