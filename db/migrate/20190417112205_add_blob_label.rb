class AddBlobLabel < ActiveRecord::Migration[5.2]
  def change
    add_column :blobs, :label, :string, null: false, default: ''
  end
end
