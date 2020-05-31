# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_jsonapi_exception

  def render_jsonapi_exception(exception, status: :bad_request)
    error_data = ErrorData.new(exception)
    render jsonapi_errors: error_data, status: status
  end
end
