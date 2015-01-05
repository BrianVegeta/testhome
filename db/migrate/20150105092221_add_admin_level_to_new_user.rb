class AddAdminLevelToNewUser < ActiveRecord::Migration
  def change
  	add_column :new_users, :admin_level, :integer
  end
end
