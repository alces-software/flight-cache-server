class Container < ApplicationRecord
  validates :name, presence: true

  def bucket
    if bucket = super
      bucket
    else
      Figaro.env.default_bucket
    end
  end
end
