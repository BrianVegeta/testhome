class ChangeSmsColumnOfUserAndOrg < ActiveRecord::Migration
  def self.up
    change_column "users" , "sms_amount",  :integer , :default => 0,   :null => false
    change_column "organizations" , "sms_amount",  :integer , :default => 0,   :null => false
    add_column :users , :sms_setting , :string
    add_column :organizations , :sms_setting , :string #雖為hash，不過節省db所以可用nil
  end

  def self.down
    remove_column :users , :sms_setting
    remove_column :organizations , :sms_setting
    change_column "users" , "sms_amount",  :float , :default => 0.0,   :null => false
    change_column "organizations" , "sms_amount",  :float , :default => 0.0,   :null => false
  end
end
