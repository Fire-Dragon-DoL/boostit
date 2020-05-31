# frozen_string_literal: true

require 'test_helper'

class SignUpTest < IntegrationCase
  test 'With valid email, password and password confirmation is successful' do
    email = ::User::Sample.email
    password = ::User::Sample.password
    params = {
      user: {
        email: email, password: password, password_confirmation: password
      }
    }

    post user_registration_url, params: params.to_json, headers: jsonapi_headers

    assert @response.status >= 200 && @response.status <= 299
  end

  test 'With same email it conflicts' do
    email = ::User::Sample.email
    password = ::User::Sample.password
    params = {
      user: {
        email: email, password: password, password_confirmation: password
      }
    }

    post user_registration_url, params: params.to_json, headers: jsonapi_headers
    prior_status = @response.status
    post user_registration_url, params: params.to_json, headers: jsonapi_headers

    assert prior_status >= 200 && prior_status <= 299
    assert @response.status != prior_status
    assert @response.status == 409
  end

  test 'With invalid email it errors' do
    email = ::User::Sample.invalid_email
    password = ::User::Sample.password
    params = {
      user: {
        email: email, password: password, password_confirmation: password
      }
    }

    post user_registration_url, params: params.to_json, headers: jsonapi_headers

    assert @response.status == 403
  end

  test 'With invalid password it errors' do
    email = ::User::Sample.email
    password = ::User::Sample.too_short_password
    params = {
      user: {
        email: email, password: password, password_confirmation: password
      }
    }

    post user_registration_url, params: params.to_json, headers: jsonapi_headers

    assert @response.status == 403
  end
end
