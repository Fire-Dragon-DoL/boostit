class SerialsController < ApplicationController
  before_action :authenticate_user!

  def current
    render json: { "current" => 0 }
  end
end
