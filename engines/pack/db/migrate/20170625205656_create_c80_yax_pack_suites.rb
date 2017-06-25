class CreateC80YaxPackSuites < ActiveRecord::Migration
  def change
    create_table :c80_yax_pack_suites do |t|
      t.string :title, null: false, limit: 255
      t.string :where, limit: 20
      t.string :url
      t.timestamps null: false
    end
  end
end
