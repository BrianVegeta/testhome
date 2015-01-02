class AddProviderAndUidtoNewUser < ActiveRecord::Migration
  def change
  	add_column :new_users, :provider, :string
  	add_column :new_users, :uid, 			:string
  end
end
