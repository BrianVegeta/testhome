class AddUserLinkToNewUser < ActiveRecord::Migration
  def change
  	add_column :new_users, :user_id, :integer, references: :users
  end
end
