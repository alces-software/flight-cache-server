class RemoveBucketFromContainers < ActiveRecord::Migration[5.2]
  def change
    remove_column :containers, :bucket
  end
end
