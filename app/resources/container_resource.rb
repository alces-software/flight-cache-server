class ContainerResource < JSONAPI::Resource
  # The containers are configured through the 'rails/admin' and should not
  # be mutable through the API

  has_many :blobs

  # Expose the ToolTag as the containers 'type'
  attribute :tool_type
  def tool_type
    @model.tool_tag.name
  end
end
