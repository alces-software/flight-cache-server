require 'aws-sdk-s3'

class Container < ApplicationRecord
  has_many :blobs
  belongs_to :access_tag
  belongs_to :group
end
