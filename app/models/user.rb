class User < ApplicationRecord
  belongs_to :group, optional: true

  has_many :containers, through: :group

  # Adds the "groups" method so it can be used in the refactoring. This will
  # likely become an many-to-many relationship
  def groups
    [group].reject(&:nil?)
  end
end
