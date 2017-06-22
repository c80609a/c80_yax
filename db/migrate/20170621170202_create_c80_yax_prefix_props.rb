class CreateC80YaxPrefixProps < ActiveRecord::Migration
  def change
    create_table :c80_yax_prefix_props do |t|
      t.references :strsubcat, index: true
      t.timestamps null: false
    end
  end
end