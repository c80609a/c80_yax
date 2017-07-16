class CreateOfOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :of_offers do |t|
      t.string :title, null: false
      t.text :desc

      t.timestamps
    end
  end
end