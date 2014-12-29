class MobileMessageFixJoinLog < ActiveRecord::Migration
  def self.up
    add_column :mobile_messages , :success , :boolean , :default => false , :null => false
    add_column :mobile_messages , :info , :string
    add_column :mobile_messages , :subject , :string
    change_column :mobile_messages , :message_id , :integer , :null => true
    remove_column :mobile_messages , :status
  end

  def self.down
    remove_column :mobile_messages , :success
    remove_column :mobile_messages , :info
    remove_column :mobile_messages , :subject
    change_column :mobile_messages , :message_id , :integer , :null => false
    add_column :mobile_messages , :status , :integer , :limit => 1
  end
end
