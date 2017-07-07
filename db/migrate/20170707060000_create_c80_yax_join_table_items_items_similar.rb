class CreateC80YaxJoinTableItemsItemsSimilar < ActiveRecord::Migration
  def self.up
    create_table :c80_yax_items_similar, id: false do |t|
      t.integer :item_id
      t.integer :similar_item_id
    end

    add_index(:c80_yax_items_similar, [:item_id, :similar_item_id], :unique => true)
    add_index(:c80_yax_items_similar, [:similar_item_id, :item_id], :unique => true)
  end

  def self.down
    remove_index(:c80_yax_items_similar, [:similar_item_id, :item_id])
    remove_index(:c80_yax_items_similar, [:item_id, :similar_item_id])
    drop_table :c80_yax_items_similar
  end
end