class CreateC80YaxJoinTablePricePropsPropNames < ActiveRecord::Migration
  def change
    create_table :c80_yax_price_props_prop_names, :id => false do |t|
      t.integer :price_prop_id, :null => false
      t.integer :prop_name_id, :null => false
    end

    add_index :c80_yax_price_props_prop_names, [:price_prop_id, :prop_name_id], name: 'too_long1'
    add_index :c80_yax_price_props_prop_names, [:prop_name_id, :price_prop_id], name: 'too_long2'

  end
end
