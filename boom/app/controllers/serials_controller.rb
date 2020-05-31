# frozen_string_literal: true

require 'domain/serial/get'
require 'domain/serial/set'
require 'domain/serial/increment'

class SerialsController < ApplicationController
  before_action :authenticate_user!

  def current
    value = ::Domain::Serial::Get.(current_user.id)
    data = SequenceNumber.new(value)

    render jsonapi: data
  end

  def reset
    serial = ::Serial::Set.build(params)

    unless serial.valid?
      render jsonapi_errors: serial.errors, status: :unprocessable_entity
      return
    end

    value = ::Domain::Serial::Set.(current_user.id, serial.current)
    data = SequenceNumber.new(value)

    render jsonapi: data
  end

  def next
    value = ::Domain::Serial::Increment.(current_user.id)
    data = SequenceNumber.new(value)

    render jsonapi: data
  end
end
