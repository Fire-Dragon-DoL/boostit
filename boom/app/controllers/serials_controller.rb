# frozen_string_literal: true

require 'domain/serial/get'
require 'domain/serial/set'
require 'domain/serial/increment'

class SerialsController < ApplicationController
  before_action :authenticate_user!

  def current
    id = current_user.id
    data = ::Domain::Serial::Get.(id)

    render json: { 'current' => data }
  end

  def reset
    serial = ::Serial::Set.build(params)

    unless serial.valid?
      head :unprocessable_entity
      return
    end

    id = current_user.id
    value = serial.current
    data = ::Domain::Serial::Set.(id, value)

    render json: { 'current' => data }
  end

  def next
    id = current_user.id
    data = ::Domain::Serial::Increment.(id)

    render json: { 'current' => data }
  end
end
