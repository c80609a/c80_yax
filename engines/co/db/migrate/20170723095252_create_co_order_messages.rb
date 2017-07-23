class CreateCoOrderMessages < ActiveRecord::Migration
  def change
    create_table :co_order_messages do |t|
      t.string :name
      t.string :date
      t.string :city
      t.string :phone
      t.text :comment

      t.timestamps
    end
  end
end