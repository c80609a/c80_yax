class CreateC80YaxPackSrows < ActiveRecord::Migration[5.0]
  def change
    create_table :c80_yax_pack_srows do |t|
      t.integer :ord, null: false, default: 0
      t.references :suite, index: true
      t.references :item, index: true

      t.timestamps null: false
    end

    add_foreign_key :c80_yax_pack_srows, :c80_yax_items, column: :item_id
    add_foreign_key :c80_yax_pack_srows, :c80_yax_pack_suites, column: :suite_id

  end
end
