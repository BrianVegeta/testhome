class AddSocialInfoToNewUser < ActiveRecord::Migration
  def change
  	add_column :new_users, :name, :string
  	add_column :new_users, :image, :string
  end
end
