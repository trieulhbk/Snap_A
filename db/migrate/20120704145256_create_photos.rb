class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :description
      t.string :name
      t.string :source
      t.integer :box_id

      t.timestamps
    end
  end
end
