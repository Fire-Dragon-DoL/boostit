class SerializableErrorData < JSONAPI::Serializable::Error
  title do
    @object.title
  end

  detail do
    @object.detail
  end
end
