class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :source_id
      t.integer :target_id
      t.string :relation_type

      t.timestamps
    end
    add_index :notifications,[:source_id,:target_id,:relation_type]
  end
end
