module SerializesWithTaggedScope
  extend ActiveSupport::Concern

  included do
    attribute(:tag_name) { |o| o.container.tag.name }
    attribute(:scope) { |o| o.container.scope }
    belongs_to(:tag) { |o| o.container.tag }
  end
end
