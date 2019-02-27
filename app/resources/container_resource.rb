class ContainerResource < JSONAPI::Resource
  immutable
  has_many :blobs

  # Expose the ToolTag as the containers 'type'
  attribute :tool_type
  def tool_type
    @model.tool_tag.name
  end
end
