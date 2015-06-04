class AddLikesCountToPhotoGallery < ActiveRecord::Migration
  def change
    add_column :photo_galleries, :likes_count, :integer
  end
end
