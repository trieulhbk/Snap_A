class CreateUserPhotoActions < ActiveRecord::Migration
  def change
    create_table :user_photo_actions do |t|
      t.integer :user_id
      t.integer :photo_id
      t.string :action

      t.timestamps
    end
  end
end
