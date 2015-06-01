class CreatePhotoGallerys < ActiveRecord::Migration
  def change
    create_table :photo_galleries do |t|
      t.string :photo_name
      t.string :photography
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :photo_galleries, [:user_id, :created_at]
  end
end
