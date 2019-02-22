class Container < ApplicationRecord
  validates :name, :bucket, presence: true, allow_blank: false

  def bucket
    if bucket = super
      bucket
    else
      Figaro.env.default_bucket
    end
  end
end
