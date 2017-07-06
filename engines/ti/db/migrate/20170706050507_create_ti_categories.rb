class CreateTiCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :ti_categories do |t|
      t.string :title
      t.integer :ord
      t.text :full
      t.references :parent_category, index: true
      t.timestamps
    end
  end
end