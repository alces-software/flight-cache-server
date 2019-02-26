class BlobResource < JSONAPI::Resource
  model_name 'ActiveStorage::Blob'
  immutable

  attribute :size, delegate: :byte_size
end
