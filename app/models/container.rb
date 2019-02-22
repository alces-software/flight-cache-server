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

  def aws_client
    @aws_client ||= Aws::S3::Client.new(region: region)
  end
end
