class CreateOfOphotos < ActiveRecord::Migration
  def change
    create_table :of_ophotos do |t|
      t.string :image
      t.references :offer, index: true

      t.timestamps null: false
    end

  end
end