# frozen_string_literal: true

class SessionsController < ::Devise::SessionsController
  # POST /resource/sign_in
  def create
    user = User.find_by(email: user_params[:email])

    # XXX: CORS seem to block parameters for wardens
    # self.resource = warden.authenticate!(auth_options)
    unless user.valid_password?(user_params[:password])
      err = UnauthorizedError.new('Unauthorized')
      error_data = ErrorData.new(err)
      render jsonapi_errors: error_data, status: :unauthorized
      return
    end

    self.resource = user
    sign_in(resource_name, resource)
    render jsonapi: nil
  end

  private

  def user_params
    params[:user] || params
  end
end
