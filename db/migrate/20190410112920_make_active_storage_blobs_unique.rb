class MakeActiveStorageBlobsUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :blobs, :active_storage_blob_id, unique: true
  end
end
