class ActiveStorage::SerializableBlob < JSONAPI::Serializable::Resource
  type 'active_storage/blobs'
  attribute :filename
  attribute :content_type
  attribute :metadata
  attribute :byte_size
  attribute :checksum
  attribute :created_at
  attribute :url { @object.service_url }
end
