class CreateC80YaxJoinTablePrefixPropsPropNames < ActiveRecord::Migration
  def change
    create_table :c80_yax_prefix_props_prop_names, :id => false do |t|
      t.integer :prefix_prop_id, :null => false
      t.integer :prop_name_id, :null => false
    end

    add_index :c80_yax_prefix_props_prop_names, [:prefix_prop_id, :prop_name_id], name: 'too_long7'
    add_index :c80_yax_prefix_props_prop_names, [:prop_name_id, :prefix_prop_id], name: 'too_long8'

  end
end
