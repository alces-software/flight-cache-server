class Blob < ApplicationRecord
  def self.upload_and_create!(io:, filename:, container:)
    as = ActiveStorage::Blob.create_after_upload!(io: io, filename: filename)
    create!(active_storage_blob: as, container: container)
  end

  belongs_to :container
  belongs_to :active_storage_blob, class_name: 'ActiveStorage::Blob'
  delegate_missing_to :active_storage_blob
end
