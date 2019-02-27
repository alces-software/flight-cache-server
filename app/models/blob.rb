class Blob < ApplicationRecord
  belongs_to :container
  belongs_to :active_storage_blob, class_name: 'ActiveStorage::Blob'
  delegate_missing_to :active_storage_blob
end
