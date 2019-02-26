class ActiveStorage::SerializableBlob < JSONAPI::Serializable::Resource
  type 'active_storage/blobs'
  attribute :filename
  attribute :content_type
  attribute :metadata
  attribute :size { @object.byte_size }
  attribute :checksum
  attribute :created_at
end
