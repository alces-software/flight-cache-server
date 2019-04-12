class MakeContainerFilenamesUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :blobs, [:filename, :container_id], unique: true
    change_column :blobs, :filename, :string, null: false
  end
end
