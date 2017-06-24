class CreateC80YaxCats < ActiveRecord::Migration
  def change
    create_table :c80_yax_cats do |t|
      t.string :title
      t.string :image
      t.string :slug
      t.integer :ord

      t.timestamps null: false
    end
  end
end
