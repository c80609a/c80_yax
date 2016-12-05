class CreateC80YaxJoinTablePropNamesStrsubcats < ActiveRecord::Migration
  def change
    create_table :c80_yax_prop_names_strsubcats, :id => false do |t|
      t.integer :prop_name_id, :null => false
      t.integer :strsubcat_id, :null => false
    end

    add_index :c80_yax_prop_names_strsubcats, [:prop_name_id, :strsubcat_id], :unique => true, :name => 'my_index_q'
    add_index :c80_yax_prop_names_strsubcats, [:strsubcat_id, :prop_name_id], :unique => true, :name => 'my_index_w'

  end
end
