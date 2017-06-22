class CreateC80YaxItems < ActiveRecord::Migration
  def change
    create_table :c80_yax_items do |t|
      t.string :title
      t.string :slug
      t.string :image
      t.text :short_desc
      t.text :full_desc
      t.boolean :is_hit
      t.boolean :is_sale
      t.boolean :is_main
      t.boolean :is_gift
      t.boolean :is_starting
      t.boolean :is_available
      t.boolean :is_ask_price
      t.references :strsubcat, index: true
      t.references :related_parent, index: true

      t.timestamps null: false
    end
  end
end
