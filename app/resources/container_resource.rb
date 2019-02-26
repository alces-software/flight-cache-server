class ContainerResource < JSONAPI::Resource
  # The containers are configured through the 'rails/admin' and should not
  # be mutable through the API
  immutable

  # Expose the ToolTag as the containers 'type'
  attribute :tool_type
  def tool_type
    @model.tool_tag.name
  end

  has_many :blobs, relation_name: :packages_blobs
end
