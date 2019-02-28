class BlobSerializer
  include FastJsonapi::ObjectSerializer
  attributes :checksum
  attribute :size, &:byte_size
  attribute :filename do |obj|
    obj.filename.to_s
  end

  belongs_to :container
end
