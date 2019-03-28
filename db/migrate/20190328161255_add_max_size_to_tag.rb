class AddMaxSizeToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :max_size, :integer, null: true
  end
end
