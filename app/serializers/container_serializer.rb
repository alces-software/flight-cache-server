class ContainerSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :tool_tag

  link :self { |c| urls.url_for(c) }

  has_many :blobs, links: {
    related: proc { |c| urls.container_blobs_url(c) }
  }
end
