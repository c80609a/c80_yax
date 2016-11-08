class CreateC80YaxIphotos < ActiveRecord::Migration
  def change
    create_table :c80_yax_iphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.references :item, index: true

      t.timestamps null: false
    end
    # add_foreign_key :ophotos, :offers
  end
end
