require 'concerns/serializes_with_tagged_scope'

class BlobSerializer < ApplicationSerializer
  include SerializesWithTaggedScope

  attributes :checksum
  attribute(:byte_size)
  attribute(:filename) { |b| b.filename.to_s }

  belongs_to :container, links: {
    related: proc { |b| urls.url_for(b.container) }
  }

  link(:self) { |b| urls.blob_url(b) }
  link(:download) { |b| urls.download_blob_url(b) }
end
