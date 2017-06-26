class CreateC80YaxPropNames < ActiveRecord::Migration
  def change
    create_table :c80_yax_prop_names, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title, null: false
      t.boolean :is_normal_price
      t.boolean :is_excluded_from_filtering
      t.references :uom, index: true
      t.references :related, index: true # NOTE:: see forbiz schema.rb:518: "prop_names" t.integer "related" (скорее всего, был забыт _id)
      t.string :regex
      t.string :comment
      t.string :opt
      t.timestamps null: false
    end
  end
end
