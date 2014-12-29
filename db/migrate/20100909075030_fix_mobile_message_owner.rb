class FixMobileMessageOwner < ActiveRecord::Migration
  def self.up
    rename_column :mobile_messages , :owner_id , :user_id
    remove_column :mobile_messages , :owner_type
    add_column :mobile_messages , :organization_id , :integer
    add_column :mobile_messages , :pay_from , :integer , :limit => 1 , :default => 0 , :null => false
  end

  def self.down
    rename_column :mobile_messages , :user_id , :owner_id
    add_column :mobile_messages , :owner_type , :string
    remove_column :mobile_messages , :organization_id
    remove_column :mobile_messages , :pay_from
  end
end
