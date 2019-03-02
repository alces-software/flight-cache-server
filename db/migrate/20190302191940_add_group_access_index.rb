class AddGroupAccessIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :containers, [:access_tag_id, :group_id], unique: true
  end
end
