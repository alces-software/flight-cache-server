class AddAssetTagNameIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :access_tags, :name, unique: true
  end
end
