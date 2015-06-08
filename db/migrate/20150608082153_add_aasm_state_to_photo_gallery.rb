class AddAasmStateToPhotoGallery < ActiveRecord::Migration
  def change
    add_column :photo_galleries, :aasm_state, :string
  end
end
