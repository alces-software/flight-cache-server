class AddBlobFilenameAndTitle < ActiveRecord::Migration[5.2]
  def change
    add_column :blobs, :title, :string
    add_column :blobs, :filename, :string
  end
end
