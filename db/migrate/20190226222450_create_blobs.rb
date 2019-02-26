class CreateBlobs < ActiveRecord::Migration[5.2]
  def change
    create_table :blobs, id: false do |t|
      t.timestamps
      t.integer :active_storage_blob_id, primary_key: true
      t.references :container, null: false, foreign_key: true
    end
    add_foreign_key :blobs,
                    :active_storage_blobs,
                    column: :active_storage_blob_id
  end
end
