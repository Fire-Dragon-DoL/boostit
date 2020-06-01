# frozen_string_literal: true

unless Rails.env.test?
  ENV.fetch('BOOM_CORS_DOMAIN').split(',').each do |domain|
    Rails.application.config.hosts << domain
  end
  Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true, logger: (-> { Rails.logger }) do
    allow do
      split_origins = ENV.fetch('BOOM_CORS_DOMAIN').split(',')
      origins *split_origins
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
