class BlobResource < JSONAPI::Resource
  immutable

  has_one :container
  attribute :size, delegate: :byte_size

  attribute :filename
  def filename
    @model.filename.to_s
  end

  # Add the download link to the API
  def custom_links(opts)
    {
      download: File.join(opts[:serializer].link_builder.self_link(self), 'download')
    }
  end
end
