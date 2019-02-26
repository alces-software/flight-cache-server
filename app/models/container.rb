require 'aws-sdk-s3'

class Container < ApplicationRecord
  belongs_to :tool_tag
  has_many_attached :packages

  def join(*parts)
    File.join(tool_tag.name, *a)
  end
end
