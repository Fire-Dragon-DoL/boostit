# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/v1', format: :json do
    # devise_for :users
    devise_for :users, skip: :all
    devise_scope :user do
      post '/', to: 'registrations#create', as: :user_registration
      post '/sign_in', to: 'devise/sessions#create', as: :user_session
      get '/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    end

    get '/current', to: 'serials#current', as: :current_serial
  end
end
