class AddTiListedToCategories < ActiveRecord::Migration
  def change
    add_column :ti_categories, :is_listed, :boolean
  end
end
