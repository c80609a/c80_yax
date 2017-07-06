class CreateTiProps < ActiveRecord::Migration
  def change
    create_table :ti_props do |t|
      t.integer :thumb_sm_width
      t.integer :thumb_sm_height
      t.integer :thumb_md_width
      t.integer :thumb_md_height
      t.integer :thumb_lg_width
      t.integer :thumb_lg_height
      t.timestamps
    end
  end
end