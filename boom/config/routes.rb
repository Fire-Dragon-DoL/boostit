# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/v1', format: :jsonapi do
    devise_for :users, skip: :all
    devise_scope :user do
      post '/users', to: 'registrations#create', as: :user_registration
      post '/users/sign_in', to: 'sessions#create', as: :user_session
    end

    get '/current', to: 'serials#current', as: :current_serial
    get '/next', to: 'serials#next', as: :next_serial
    put '/current', to: 'serials#reset', as: :reset_serial
  end
end
