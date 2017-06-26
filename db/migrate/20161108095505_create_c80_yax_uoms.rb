class CreateC80YaxUoms < ActiveRecord::Migration
  def change
    create_table :c80_yax_uoms, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title, null: false, limit: 50
      t.string :comment
      t.string :regex
      t.boolean :is_number

      t.timestamps null: false
    end
  end
end
