class CreateC80YaxCommonProps < ActiveRecord::Migration
  def change
    create_table :c80_yax_common_props do |t|
      t.references :strsubcat, index: true
      t.timestamps null: false
    end
  end
end