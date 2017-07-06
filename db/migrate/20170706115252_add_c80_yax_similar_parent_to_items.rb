class AddC80YaxSimilarParentToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :c80_yax_items, :similar_parent_id, :integer, index: true
  end
end
