# frozen_string_literal: true

require 'test_helper'

class UnauthenticatedTest < IntegrationCase
  test 'When getting current integer, unauthorized' do
    get current_serial_url

    assert @response.status == 401
  end
end
