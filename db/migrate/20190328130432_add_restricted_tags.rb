class AddRestrictedTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :restricted?, :boolean, default: false
  end
end
