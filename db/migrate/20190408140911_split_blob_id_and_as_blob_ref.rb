class SplitBlobIdAndAsBlobRef < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE blobs DROP CONSTRAINT blobs_pkey"
    add_column :blobs, :id, :primary_key
  end
end
