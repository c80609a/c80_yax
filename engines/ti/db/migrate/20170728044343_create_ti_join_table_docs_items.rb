class CreateTiJoinTableDocsItems < ActiveRecord::Migration
  def self.up
    create_table :ti_docs_items, id: false do |t|
      t.integer :doc_id
      t.integer :item_id
    end

    add_index(:ti_docs_items, [:doc_id, :item_id], :unique => true)
    add_index(:ti_docs_items, [:item_id, :doc_id], :unique => true)
  end

  def self.down
    remove_index(:ti_docs_items, [:item_id, :doc_id])
    remove_index(:ti_docs_items, [:doc_id, :item_id])
    drop_table :ti_docs_items
  end
end