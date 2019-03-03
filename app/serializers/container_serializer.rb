class ContainerSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  attribute(:tag) { |c| c.access_tag.name }

  link(:self) { |c| urls.url_for(c) }

  has_many :blobs, links: {
    related: proc { |c| urls.container_blobs_url(c) }
  }
end
