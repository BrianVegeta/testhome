class MapOriFix < ActiveRecord::Migration
  def self.up
    change_column :maps , :owner_id , :integer , :null => true
    change_column :maps , :owner_type , :string , :null => true
  end

  def self.down
    change_column :maps , :owner_id , :integer , :null => false
    change_column :maps , :owner_type , :string , :null => false
  end
end
