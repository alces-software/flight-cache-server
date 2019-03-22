module SerializesWithTaggedScope
  extend ActiveSupport::Concern

  included do
    attribute(:tag_name) { |o| o.container.tag.name }
    attribute(:scope) { |o| o.container.scope }

    tag_kwargs = {
      links: { related: proc { |o| urls.tag_url(o.container.tag) } }
    }
    belongs_to(:tag, **tag_kwargs) { |o| o.container.tag }
  end
end
