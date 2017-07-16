class CreateOfJoinTableItemsOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :of_items_offers, :id => false do |t|
      t.integer :item_id, :null => false
      t.integer :offer_id, :null => false
    end

    add_index :of_items_offers, [:item_id, :offer_id], :unique => true, :name => 'of_index1'
    add_index :of_items_offers, [:offer_id, :item_id], :unique => true, :name => 'of_index2'

  end
end
