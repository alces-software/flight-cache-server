class RenameUserGroupToDefaultGroup < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :group_id, :default_group_id
  end
end
