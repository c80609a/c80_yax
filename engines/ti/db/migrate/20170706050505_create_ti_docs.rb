class CreateTiDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :ti_docs do |t|
      t.string :title
      t.text :full
      t.string :slug

      t.timestamps
    end
  end
end