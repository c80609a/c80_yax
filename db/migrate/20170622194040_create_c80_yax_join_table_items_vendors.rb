class CreateC80YaxJoinTableItemsVendors < ActiveRecord::Migration
  def change
    create_table :c80_yax_items_vendors, :id => false do |t|
      t.integer :item_id, :null => false
      t.integer :vendor_id, :null => false
    end

    add_index :c80_yax_items_vendors, [:item_id, :vendor_id], name: 'too_long9'
    add_index :c80_yax_items_vendors, [:vendor_id, :item_id], name: 'too_long10'

  end
end
