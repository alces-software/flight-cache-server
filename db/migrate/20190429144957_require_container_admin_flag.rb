class RequireContainerAdminFlag < ActiveRecord::Migration[5.2]
  def change
    change_column :containers, :admin, :boolean, null: false
  end
end
