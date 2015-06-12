class AddAasmStateToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :aasm_state, :string
  end
end
