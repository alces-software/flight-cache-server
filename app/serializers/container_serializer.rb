require 'concerns/serializes_with_tagged_scope'

class ContainerSerializer < ApplicationSerializer
  include SerializesWithTaggedScope

  link(:self) { |c| urls.url_for(c) }

  has_many :blobs, links: {
    related: proc { |c| urls.container_blobs_url(c) }
  }
end
