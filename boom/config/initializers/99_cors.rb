# frozen_string_literal: true

unless Rails.env.test?
  Rails.application.config.hosts << ENV.fetch('BOOM_CORS_DOMAIN')
  Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
    allow do
      origins ENV.fetch('BOOM_CORS_DOMAIN')
      resource '*',
               headers: :any,
               # headers: %w(Content-Type Accept Authorization),
               methods: :any,
               # expose: :any,
               expose: %w[Content-Type Authorization ETags Transfer-Encoding],
               max_age: 600
    end
  end
end
