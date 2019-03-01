class Group < ApplicationRecord
  has_many :containers
  has_many :users
end
