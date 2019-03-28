class Blob < ApplicationRecord
  def self.upload_and_create!(io:, filename:, container:)
    container.raise_if_exceeds_max_size(io)
    transaction do
      as = ActiveStorage::Blob.create_after_upload!(io: io, filename: filename)
      create!(active_storage_blob: as, container: container)
    end
  end

  belongs_to :container
  belongs_to :active_storage_blob, class_name: 'ActiveStorage::Blob'
  delegate_missing_to :active_storage_blob

  alias_attribute :protected?, :protected

  after_destroy :purge_active_storage_blob

  def protected
    super() || container.restricted?
  end

  def readable?(other)
    access?(:readable?, other)
  end

  def writable?(other)
    return false if self.protected?
    access?(:writable?, other)
  end

  private

  def purge_active_storage_blob
    active_storage_blob.purge
  end

  def access?(method, other)
    container.public_send(method, other)
  end
end
