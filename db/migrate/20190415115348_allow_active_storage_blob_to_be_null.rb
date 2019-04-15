class AllowActiveStorageBlobToBeNull < ActiveRecord::Migration[5.2]
  def up
    change_column :blobs, :active_storage_blob_id, :bigint, null: true, default: nil
  end

  def down
    change_column :blobs, :active_storage_blob_id, :integer, null: false
  end
end
