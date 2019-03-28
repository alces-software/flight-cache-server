class Tag < ApplicationRecord
  has_many :containers

  validates :name, presence: true, allow_blank: false, uniqueness: true

  alias_attribute :restricted?, :restricted
end
