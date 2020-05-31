# frozen_string_literal: true

class RegistrationsController < ::Devise::RegistrationsController
  # POST /resource
  def create
    build_resource(sign_up_params)
    resource.save

    unless resource.persisted?
      clean_resources
      render jsonapi_errors: resource.errors, status: :forbidden
      return
    end

    sign_up_or_expire

    render jsonapi: resource
  end

  private

  def clean_resources
    clean_up_passwords(resource)
    set_minimum_password_length
  end

  def sign_up_or_expire
    return sign_up(resource_name, resource) if resource.active_for_authentication?

    expire_data_after_sign_in!
  end
end
