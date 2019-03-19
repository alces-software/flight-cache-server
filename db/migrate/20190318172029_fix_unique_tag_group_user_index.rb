class FixUniqueTagGroupUserIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :containers, [:access_tag_id, :group_id, :user_id]
    add_index :containers, [:access_tag_id, :group_id], unique: true
    add_index :containers, [:access_tag_id, :user_id], unique: true
  end
end
