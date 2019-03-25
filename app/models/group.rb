class Group < ApplicationRecord
  has_many :containers
  has_many :users, foreign_key: 'default_group_id'

  def users
    name == 'public' ? User.all : super
  end
end
