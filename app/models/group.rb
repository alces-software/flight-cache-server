class Group < ApplicationRecord
  include HasContainerOwnership.new(:containers)

  has_many :containers
  has_many :users, foreign_key: 'default_group_id'

  def readable?(other)
    if self.public?
      true
    else
      users.include?(other)
    end
  end

  def writable?(other)
    if self.public?
      false
    else
      users.include?(other)
    end
  end

  def public?
    name == 'public'
  end
end
