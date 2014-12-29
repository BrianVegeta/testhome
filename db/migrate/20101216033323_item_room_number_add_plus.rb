class ItemRoomNumberAddPlus < ActiveRecord::Migration
  def self.up
    add_column "items" , "pattern_room_plus" , :integer , :limit => 1 , :default => 0, :null => false
  end

  def self.down
    remove_column "items" , "pattern_room_plus"
  end
end