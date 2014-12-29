class RenameTableSmsToMobileMessages < ActiveRecord::Migration
  def self.up
    rename_table :sms , :mobile_messages
    remove_column :mobile_messages , :serial
  end

  def self.down
    add_column :mobile_messages , :serial , :string , :limit => 36
    rename_table :mobile_messages , :sms
  end
end
