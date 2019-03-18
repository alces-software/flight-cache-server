class User < ApplicationRecord
  has_many :user_containers, class_name: 'Container'

  belongs_to :group, optional: true

  def group_containers
    group&.containers || []
  end

  def containers
    [user_containers, group_containers].flatten
  end

  # Adds the "groups" method so it can be used in the refactoring. This will
  # likely become an many-to-many relationship
  def groups
    [group].reject(&:nil?)
  end
end
