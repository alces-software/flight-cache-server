class ContainerSerializer
  include FastJsonapi::ObjectSerializer
  has_many :blobs
  belongs_to :tool_tag
end
