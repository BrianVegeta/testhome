class AddOrderSerialColumn < ActiveRecord::Migration
  def self.up
    add_column :orders , :serial , :string , :null => false
    add_column :orders , :pay_kind , :integer , :limit => 1 , :null => false , :default => 0
    add_column :orders , :pay_type , :integer , :limit => 1 , :null => false
  end

  def self.down
    remove_column :orders , :pay_kind
    remove_column :orders , :pay_type
    remove_column :orders , :serial
  end
end
