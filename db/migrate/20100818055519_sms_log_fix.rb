class SmsLogFix < ActiveRecord::Migration
  def self.up
    rename_table :sms_logs , :sms

    remove_column :sms , :item_id
    add_column :sms , :source_info , :string , :null => false
    add_column :sms , :remote_ip , :string , :limit => 15 , :null => false
    add_column :sms , :from_id , :integer
    add_column :sms , :from_type , :string
    add_column :sms , :phone , :string , :limit => 20 #對象電話
    add_column :sms , :total_amount , :float , :default => 0.0 #帳戶餘額(小數點)
    add_column :sms , :cost_amount , :float , :default => 0.0 #扣點(小數點)[高於基數 == 國際簡訊]
    add_column :sms , :send_amount , :integer , :limit => 1 #發送的通數(整數)
    add_column :sms , :serial , :string , :limit => 36 #回傳的uuid
    add_column :sms , :status , :integer , :limit => 1 #回傳的狀態碼(model對應array化....)

    add_column :users , :sms_amount , :float , :default => 0.0 , :null => false
    change_column :organizations , :sms_amount , :float , :default => 0.0 , :null => false
  end

  def self.down
    remove_column :users , :sms_amount
    change_column :organizations , :sms_amount , :integer , :default => 0 , :null => false

    add_column :sms , :item_id , :integer
    remove_column :sms , :source_info
    remove_column :sms , :remote_ip
    remove_column :sms , :from_id
    remove_column :sms , :from_type
    remove_column :sms , :phone
    remove_column :sms , :total_amount
    remove_column :sms , :cost_amount
    remove_column :sms , :send_amount
    remove_column :sms , :serial
    remove_column :sms , :status

    rename_table :sms , :sms_logs
  end
end
