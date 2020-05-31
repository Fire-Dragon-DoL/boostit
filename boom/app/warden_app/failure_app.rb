# frozen_string_literal: true

class FailureApp < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'application/vnd.api+json'
    self.response_body = {
      'errors' => [{ 'status' => '401', 'title' => 'Unauthorized' }]
    }.to_json
  end
end
