class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
