require 'aws-sdk-s3'

class Container < ApplicationRecord
  has_many :blobs
  belongs_to :tool_tag

  def join(*parts)
    File.join(tool_tag.name, *a)
  end
end
