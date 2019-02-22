require 'aws-sdk-s3'

class Container < ApplicationRecord
  belongs_to :tool_tag

  validates :bucket, presence: true, allow_blank: false

  def bucket
    if bucket = super
      bucket
    else
      Figaro.env.default_bucket
    end
  end

  def client
    @client ||= begin
      Aws::S3::Client.new
    end
  end
end
