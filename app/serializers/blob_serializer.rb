class BlobSerializer < ApplicationSerializer
  attributes :checksum
  attribute(:size, &:byte_size)
  attribute(:filename) { |o| o.filename.to_s }

  belongs_to :container, links: {
    related: proc { |b| urls.url_for(b.container) }
  }

  link(:self) { |b| urls.blob_url(b) }
  link(:download) { |b| urls.download_blob_url(b) }
end
