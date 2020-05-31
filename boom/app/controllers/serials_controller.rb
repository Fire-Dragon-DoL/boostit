# frozen_string_literal: true

require 'domain/serial/get'
require 'domain/serial/set'
require 'domain/serial/increment'

class SerialsController < ApplicationController
  before_action :authenticate_user!

  def current
    data = ::Domain::Serial::Get.(current_user.id)

    render json: { 'current' => data }
  end

  def reset
    serial = ::Serial::Set.build(params)

    unless serial.valid?
      head :unprocessable_entity
      return
    end

    data = ::Domain::Serial::Set.(current_user.id, serial.current)

    render json: { 'current' => data }
  end

  def next
    data = ::Domain::Serial::Increment.(current_user.id)

    render json: { 'current' => data }
  rescue RangeError
    head :bad_request
  end
end
