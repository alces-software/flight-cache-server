class Tag < ApplicationRecord
  has_many :containers

  validates :name, presence: true, allow_blank: false, uniqueness: true

  alias_attribute :restricted?, :restricted

  def max_size
    super() || Figaro.env.default_upload_limit.to_i
  end
end
