class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :photo_gallery, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :likes, [:photo_gallery_id, :user_id], unique: true

  end
end
