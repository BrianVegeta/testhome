class FixMobileColumn < ActiveRecord::Migration
  def self.up
    remove_column :mobile_messages , :organization_id
    add_column :mobile_messages , :send_by_admin , :boolean , :default => false , :null => false
  end

  def self.down
    add_column :mobile_messages , :organization_id , :integer
    remove_column :mobile_messages , :send_by_admin
  end
end
