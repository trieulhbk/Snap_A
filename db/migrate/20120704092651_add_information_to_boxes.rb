class AddInformationToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :title, :string
    add_column :boxes, :description, :string
  end
end
