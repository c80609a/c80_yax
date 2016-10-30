class CreateC80YaxStrsubcats < ActiveRecord::Migration
  def change
    create_table :c80_yax_strsubcats do |t|
      t.string :title
      t.string :slug
      t.integer :ord
      t.references :parent, index: true

      t.timestamps null: false
    end
  end
end
