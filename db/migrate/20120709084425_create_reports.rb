class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :source_id
      t.integer :target_id
      t.string :title

      t.timestamps
    end
    add_index :reports,[:source_id,:target_id,:title]
  end
end
