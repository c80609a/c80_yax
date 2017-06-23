class CreateC80YaxJoinTableMainPropsPropNames < ActiveRecord::Migration
  def change
    create_table :c80_yax_main_props_prop_names, :id => false do |t|
      t.integer :main_prop_id, :null => false
      t.integer :prop_name_id, :null => false
    end

    add_index :c80_yax_main_props_prop_names, [:main_prop_id, :prop_name_id], name: 'too_long3'
    add_index :c80_yax_main_props_prop_names, [:prop_name_id, :main_prop_id], name: 'too_long4'

  end
end
