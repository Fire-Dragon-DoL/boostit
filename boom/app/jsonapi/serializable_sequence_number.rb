# frozen_string_literal: true

class SerializableSequenceNumber < ::JSONAPI::Serializable::Resource
  type 'sequence_numbers'

  attributes :current
end
