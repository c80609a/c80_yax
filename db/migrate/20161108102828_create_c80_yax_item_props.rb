class CreateC80YaxItemProps < ActiveRecord::Migration
  def change
    create_table :c80_yax_item_props, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :value
      t.references :item, index: true
      t.references :prop_name, index: true

      t.timestamps null: false
    end
    # add_foreign_key :item_props, :items
    # add_foreign_key :item_props, :prop_names
  end
end
