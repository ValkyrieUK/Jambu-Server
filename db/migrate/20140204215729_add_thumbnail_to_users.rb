class AddThumbnailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_thumbnail, :string
  end
end
