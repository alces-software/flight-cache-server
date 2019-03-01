class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.index :name, unique: true

      t.timestamps
    end

    add_reference :users, :group, foreign_key: true
    add_reference :containers, :group, foreign_key: true, null: false
  end
end
