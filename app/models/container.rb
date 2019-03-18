require 'aws-sdk-s3'

class Container < ApplicationRecord
  validates :user, absence: true, if: :group
  validates :user, presence: true, unless: :group

  validates :group, absence: true, if: :user
  validates :group, presence: true, unless: :user

  has_many :blobs
  belongs_to :access_tag

  belongs_to :group, optional: true
  belongs_to :user, optional: true
end
