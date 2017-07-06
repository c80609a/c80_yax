class CreateTiDphotos < ActiveRecord::Migration
  def change
    create_table :ti_dphotos do |t|
      t.string :image
      t.references :doc, index: true

      t.timestamps null: false
    end

  end
end