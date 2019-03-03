class AccessTag < ApplicationRecord
  has_many :containers

  validates :name, presence: true, allow_blank: false, uniqueness: true
end
