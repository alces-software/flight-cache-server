class AddAdminOnlyContainers < ActiveRecord::Migration[5.2]
  def change
    add_column :containers, :admin, :boolean, default: false
    remove_index :containers, [:tag_id, :group_id]
    remove_index :containers, [:tag_id, :user_id]
    add_index :containers, [:tag_id, :group_id, :admin], unique: true
    add_index :containers, [:tag_id, :user_id, :admin], unique: true
  end
end
