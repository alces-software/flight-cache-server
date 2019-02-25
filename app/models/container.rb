require 'aws-sdk-s3'

class Container < ApplicationRecord
  belongs_to :tool_tag

  validates :bucket, presence: true, allow_blank: false

  def bucket
    (b = super) ? b : Figaro.env.default_bucket
  end

  def region
    Figaro.env.default_region
  end

  def s3_client
    @s3_client ||= Aws::S3::Client.new(region: region)
  end

  def join(*parts)
    File.join(tool_tag.name, *a)
  end
end
