class CreateC80YaxJoinTableCommonPropsPropNames < ActiveRecord::Migration
  def change
    create_table :c80_yax_common_props_prop_names, :id => false do |t|
      t.integer :common_prop_id, :null => false
      t.integer :prop_name_id, :null => false
    end

    add_index :c80_yax_common_props_prop_names, [:common_prop_id, :prop_name_id], name: 'too_long5'
    add_index :c80_yax_common_props_prop_names, [:prop_name_id, :common_prop_id], name: 'too_long6'

  end
end
