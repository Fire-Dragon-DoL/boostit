# frozen_string_literal: true

class SessionsController < ::Devise::SessionsController
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render jsonapi: nil
  end

  private

  def user_params
    params[:user] || params
  end
end
