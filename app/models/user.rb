class User < ApplicationRecord
  belongs_to :group, optional: true

  has_many :containers, through: :group
end
