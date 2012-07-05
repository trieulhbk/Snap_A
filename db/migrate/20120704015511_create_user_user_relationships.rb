class CreateUserUserRelationships < ActiveRecord::Migration
	def change
		create_table :user_user_relationships do |t|
			t.integer :following_id
			t.integer :follower_id

			t.timestamps
		end

		add_index :user_user_relationships, :follower_id
		add_index :user_user_relationships, :following_id
		add_index :user_user_relationships, [:follower_id, :following_id], unique: true

	end
end
