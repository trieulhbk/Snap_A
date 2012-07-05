class AddInfomationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :string
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :gender, :string
    add_column :users, :language, :string
    add_column :users, :location, :string
    add_column :users, :userName, :string
    add_column :users, :website, :string
  end
end
