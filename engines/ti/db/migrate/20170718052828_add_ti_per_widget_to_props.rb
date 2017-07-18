class AddTiPerWidgetToProps < ActiveRecord::Migration
  def change
    add_column :ti_props, :per_widget, :integer
    add_column :ti_props, :per_page, :integer
  end
end
