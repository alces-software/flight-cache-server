class RenameToolTagsToAccessTags < ActiveRecord::Migration[5.2]
  def change
    rename_table :tool_tags, :access_tags
    rename_column :containers, :tool_tag_id, :access_tag_id
  end
end
