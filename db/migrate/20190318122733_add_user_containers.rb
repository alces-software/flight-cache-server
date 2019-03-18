class AddUserContainers < ActiveRecord::Migration[5.2]
  def change
    remove_index  :containers, [:access_tag_id, :group_id]
    add_reference :containers, :user, null: true, foreign_key: true, index: true
    add_index     :containers, [:access_tag_id, :group_id, :user_id], unique: true
    change_column :containers, :group_id, :bigint, null: true
  end
end
