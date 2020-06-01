# frozen_string_literal: true
# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'example.com'
#
#     resource '*',
#       headers: :any,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end

Rails.application.config.hosts << ENV.fetch('BOOM_CORS_DOMAIN')
# Rails.application.config.middleware.insert_after Warden::Manager, Rack::Cors do
Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
  allow do
    origins ENV.fetch('BOOM_CORS_DOMAIN')
    resource '*',
      headers: :any,
      # headers: %w(Content-Type Accept Authorization),
      methods: :any,
      # expose: :any,
      expose: %w(Content-Type Authorization ETags Transfer-Encoding),
      max_age: 600
  end
end
