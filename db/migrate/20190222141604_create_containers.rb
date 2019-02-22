class CreateContainers < ActiveRecord::Migration[5.1]
  def change
    create_table :containers do |t|
      t.string :name, null: false
      t.string :bucket, null: true

      t.timestamps
    end
  end
end
