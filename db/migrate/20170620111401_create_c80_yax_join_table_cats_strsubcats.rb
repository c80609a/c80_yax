class CreateC80YaxJoinTableCatsStrsubcats < ActiveRecord::Migration
  def change
    create_table :c80_yax_cats_strsubcats, :id => false do |t|
      t.integer :cat_id, :null => false
      t.integer :strsubcat_id, :null => false
    end

    add_index :c80_yax_cats_strsubcats, [:cat_id, :strsubcat_id], :unique => true, :name => 'my_index_q'
    add_index :c80_yax_cats_strsubcats, [:strsubcat_id, :cat_id], :unique => true, :name => 'my_index_w'

  end
end
