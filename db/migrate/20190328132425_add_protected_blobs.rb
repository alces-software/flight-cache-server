class AddProtectedBlobs < ActiveRecord::Migration[5.2]
  def change
    add_column :blobs, :protected?, :boolean, default: false
  end
end
