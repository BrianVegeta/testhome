class RebuildMessageAndSms < ActiveRecord::Migration
  def self.up
    rename_column :messages , :with_id , :from_id

    #mapping MobileMessage to Message & MobileMessage link to Message

    add_column :messages , :source_info , :string
    add_column :messages , :remote_ip , :string , :limit => 15 , :null => false
    add_column :messages , :from_type , :string
    add_column :messages , :level_kind , :integer , :limit => 1 , :default => 0

    add_column :mobile_messages , :message_id , :integer , :null => false
    remove_column :mobile_messages , :source_info
    remove_column :mobile_messages , :remote_ip
    remove_column :mobile_messages , :from_type
    remove_column :mobile_messages , :from_id
    remove_column :mobile_messages , :kind
    remove_column :mobile_messages , :pay_from

    add_column :mobile_messages , :pay_from_org_id , :integer
  end

  def self.down
    rename_column :messages , :from_id , :with_id

    remove_column :messages , :source_info
    remove_column :messages , :remote_ip
    remove_column :messages , :from_type
    remove_column :messages , :level_kind

    remove_column :mobile_messages , :message_id
    add_column :mobile_messages , :source_info , :string
    add_column :mobile_messages , :remote_ip , :string
    add_column :mobile_messages , :from_type , :string
    add_column :mobile_messages , :from_id , :integer
    add_column :mobile_messages , :kind , :integer
    add_column :mobile_messages , :pay_from , :integer
    
    remove_column :mobile_messages , :pay_from_org_id
  end
end
