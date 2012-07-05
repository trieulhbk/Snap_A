class CreateUserBoxFollows < ActiveRecord::Migration
  def change
    create_table :user_box_follows do |t|
      t.integer :user_id
      t.integer :box_id

      t.timestamps
    end
  end
end
