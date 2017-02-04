class AddColumnToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :user_id, :string
  end
end
