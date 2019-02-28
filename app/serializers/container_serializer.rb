class ContainerSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  has_many :blobs
  belongs_to :tool_tag

  link :self { |c| urls.container_url(c) }
end
