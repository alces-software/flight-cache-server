class BlobSerializer < ApplicationSerializer
  attributes :checksum
  attribute :size, &:byte_size
  attribute :filename { |o| o.filename.to_s }

  belongs_to :container

  link :self { |b| urls.blob_url(b) }
end
