class CreateC80YaxJoinTableColorsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :c80_yax_colors_items, :id => false do |t|
      t.integer :color_id, :null => false
      t.integer :item_id, :null => false
    end

    add_index :c80_yax_colors_items, [:color_id, :item_id], name: 'too_long17'
    add_index :c80_yax_colors_items, [:item_id, :color_id], name: 'too_long18'

  end
end
