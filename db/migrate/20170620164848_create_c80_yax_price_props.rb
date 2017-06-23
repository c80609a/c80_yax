class CreateC80YaxPriceProps < ActiveRecord::Migration
  def change
    create_table :c80_yax_price_props do |t|
      t.references :strsubcat, index: true
      t.timestamps null: false
    end
    # add_foreign_key :c80_yax_price_props, :strsubcats
  end
end