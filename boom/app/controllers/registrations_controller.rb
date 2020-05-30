class RegistrationsController < ::Devise::RegistrationsController
  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save

    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        render json: resource.as_json
      else
        expire_data_after_sign_in!
        render json: resource.as_json
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      head :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    head :conflict
  end
end
