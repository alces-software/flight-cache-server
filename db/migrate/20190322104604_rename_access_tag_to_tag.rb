class RenameAccessTagToTag < ActiveRecord::Migration[5.2]
  def change
    rename_table :access_tags, :tags
    rename_column :containers, :access_tag_id, :tag_id
  end
end
