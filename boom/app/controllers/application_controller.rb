# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_jsonapi_exception
  rescue_from ActiveRecord::RecordNotUnique, with: :render_conflict

  before_action :set_content_type
  before_action :expect_jsonapi_content_type
  before_action :expect_jsonapi_accept

  ACCEPT_REGEXP = /application\/vnd\.api\+json\s*;?\s*,/
  LAST_ACCEPT_REGEXP = /application\/vnd\.api\+json\s*;?\s*$/
  JSONAPI_MIME_TYPE = 'application/vnd.api+json'

  def render_jsonapi_exception(exception, status: :bad_request)
    error_data = ErrorData.new(exception)
    render jsonapi_errors: error_data, status: status
  end

  private

  def expect_jsonapi_content_type
    req_content_type = request.headers["Content-Type"]

    return if req_content_type == JSONAPI_MIME_TYPE

    err = UnsupportedMediaTypeError.new('Unsupported media type')
    error_data = ErrorData.new(err)
    render jsonapi_errors: error_data, status: :unsupported_media_type
  end

  def expect_jsonapi_accept
    req_accept = request.headers["Accept"]

    return if req_accept =~ ACCEPT_REGEXP || req_accept =~ LAST_ACCEPT_REGEXP

    err = NotAcceptableError.new('Not acceptable')
    error_data = ErrorData.new(err)
    render jsonapi_errors: error_data, status: :not_acceptable
  end

  def set_content_type
    response.set_header('Content-Type', JSONAPI_MIME_TYPE)
  end

  def render_conflict(exception)
    render_jsonapi_exception(exception, status: :conflict)
  end
end
