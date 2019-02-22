class CreateToolTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tool_tags do |t|
      t.string :name

      t.timestamps
    end

    add_reference :containers, :tool_tag, foreign_key: true
    remove_column :containers, :name
  end
end
