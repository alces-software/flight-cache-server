class User < ApplicationRecord
  belongs_to :default_group,
             optional: true,
             foreign_key: 'group_id',
             class_name: 'Group'
  has_many   :user_containers, class_name: 'Container'

  # Adds the "groups" method so it can be used in the refactoring. This will
  # likely become an many-to-many relationship
  def groups
    [default_group].reject(&:nil?)
  end

  def containers
    user_containers.or(group_containers).or(public_containers)
  end

  def group_containers
    Container.where(group: (default_group || -1))
  end

  def public_containers
    Group.find_by_name('public').containers
  end
end
