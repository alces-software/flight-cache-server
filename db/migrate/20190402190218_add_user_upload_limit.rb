class AddUserUploadLimit < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :upload_limit, :integer, null: true
  end
end
