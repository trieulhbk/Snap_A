class AddCategoryIdToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :category_id, :integer
  end
end
