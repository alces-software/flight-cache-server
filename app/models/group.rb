class Group < ApplicationRecord
  has_many :containers
  has_many :users

  def users
    name == 'public' ? User.all : super
  end
end
