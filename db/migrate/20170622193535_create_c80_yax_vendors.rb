class CreateC80YaxVendors < ActiveRecord::Migration
  def change
    create_table :c80_yax_vendors do |t|
      t.string   "title",      limit: 255
      t.text     "short",      limit: 65535
      t.text     "content",    limit: 16777215
      t.boolean  "as_is",      limit: 1
      t.timestamps null: false
    end
  end
end