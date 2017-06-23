class CreateC80YaxMainProps < ActiveRecord::Migration
  def change
    create_table :c80_yax_main_props do |t|
      t.references :strsubcat, index: true
      t.timestamps null: false
    end
  end
end