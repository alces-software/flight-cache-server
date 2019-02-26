class SerializableContainer < JSONAPI::Serializable::Resource
  type 'containers'
  attribute :created_at
  attribute :updated_at
  has_one :tool_tag
  has_many :packages_attachments
  has_many :packages_blobs
end
