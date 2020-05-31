# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'devise/jwt/test_helpers'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class IntegrationCase < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def parsed_body
    JSON.parse(@response.body)
  end

  def register_and_sign_in(id = nil)
    user = User::Sample.random
    user.id = id unless id.nil?
    user.save!

    sign_in(user)

    user
  end
end
