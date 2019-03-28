class RemoveQuestionMarkFromDb < ActiveRecord::Migration[5.2]
  def change
    rename_column :blobs, :protected?, :protected
    rename_column :tags, :restricted?, :restricted
  end
end
