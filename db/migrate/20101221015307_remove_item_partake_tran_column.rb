class RemoveItemPartakeTranColumn < ActiveRecord::Migration
  def self.up
    remove_column "item_partakes" , "trans"
  end

  def self.down
    add_column "item_partakes" , "trans" , :integer , :limit => 1, :default => 0, :null => false
  end
end
