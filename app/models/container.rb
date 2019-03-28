require 'aws-sdk-s3'

class Container < ApplicationRecord
  # validates presence user XOR group
  [owners = [:user, :group], owners.reverse].each do |owner1, owner2|
    belongs_to owner1, optional: true
    validates owner1, absence: true, if: owner2
    validates owner1, presence: true, unless: owner2
  end

  has_many :blobs
  belongs_to :tag

  # Dummy method for use in the serialization. This way the container can
  # be determined for the model without checking its type first
  def container
    self
  end

  def scope
    if group && group.name == 'public'
      :public
    elsif group
      :group
    else
      :user
    end
  end

  def readable?(other)
    access?(:readable?, other)
  end

  def writable?(other)
    access?(:writable?, other)
  end

  def owner
    user || group
  end

  private

  def access?(method, other)
    if owner.is_a?(User) && owner == other
      true
    elsif owner.is_a?(Group) && other.public_send(method, other)
      true
    else
      false
    end
  end
end
