require 'aws-sdk-s3'

class Container < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user, optional: true

  validates :user, absence: true, if: :group
  validates :user, presence: true, unless: :group

  validates :group, absence: true, if: :user
  validates :group, presence: true, unless: :user

  has_many :blobs
  belongs_to :access_tag

  def users
    if owner.is_a? User
      User.where(id: user)
    else
      group.users
    end
  end

  def has_user?(user)
    users.include?(user)
  end

  def owner
    user || group
  end
end
