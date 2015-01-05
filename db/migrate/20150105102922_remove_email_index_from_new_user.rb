class RemoveEmailIndexFromNewUser < ActiveRecord::Migration
  def self.up
  	remove_index :new_users, name: :index_new_users_on_email
  end
  def self.down
  	add_index :new_users, :email, unique: true
  end
end
