class AddPersistenceTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :persistence_token, :string
    add_column :users, :single_access_token, :string
    add_index  :users, :persistence_token
    add_index  :users, :single_access_token
  end
end
