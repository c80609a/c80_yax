class CreateC80YaxColors < ActiveRecord::Migration[5.0]
  def change
    create_table :c80_yax_colors do |t|
      t.string :title, null: false, limit: 50
      t.string :value, null: false, limit: 50
      t.string :skidka, limit: 255
      t.timestamps null: false
    end
  end
end
