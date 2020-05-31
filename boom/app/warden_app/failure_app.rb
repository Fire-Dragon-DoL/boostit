# frozen_string_literal: true

class FailureApp < Devise::FailureApp
  def respond
    body = {
      errors: [{ status: '401', title: 'Unauthorized', source: {} }],
      jsonapi: JSONAPI::Rails.config.jsonapi_object
    }.as_json

    self.status = 401
    self.content_type = 'application/vnd.api+json'
    self.response_body = body.to_json
  end
end
