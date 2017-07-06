class CreateTiJoinTableCategoriesDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :ti_categories_docs, :id => false do |t|
      t.integer :category_id, :null => false
      t.integer :doc_id, :null => false
    end

    add_index :ti_categories_docs, [:category_id, :doc_id], :unique => true, :name => 'ti_index1'
    add_index :ti_categories_docs, [:doc_id, :category_id], :unique => true, :name => 'ti_index2'

  end
end
