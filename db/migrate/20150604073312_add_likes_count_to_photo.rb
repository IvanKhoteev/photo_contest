class AddLikesCountToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :likes_count, :integer, default: 0
  end
end
