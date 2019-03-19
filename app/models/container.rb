require 'aws-sdk-s3'

class Container < ApplicationRecord
  # validates presence user XOR group
  [owners = [:user, :group], owners.reverse].each do |owner1, owner2|
    belongs_to owner1, optional: true
    validates owner1, absence: true, if: owner2
    validates owner1, presence: true, unless: owner2
  end

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
