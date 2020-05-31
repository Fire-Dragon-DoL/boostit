# frozen_string_literal: true

class RegistrationsController < ::Devise::RegistrationsController
  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save

    render_resource_error && return unless resource.persisted?

    sign_up_or_expire

    render jsonapi: resource
  rescue ActiveRecord::RecordNotUnique => err
    render_jsonapi_exception(err, status: :conflict)
  end

  private

  def render_resource_error
    clean_up_passwords(resource)
    set_minimum_password_length
    render jsonapi_errors: resource.errors, status: :unprocessable_entity
    true
  end

  def sign_up_or_expire
    return sign_up(resource_name, resource) if resource.active_for_authentication?

    expire_data_after_sign_in!
  end
end
