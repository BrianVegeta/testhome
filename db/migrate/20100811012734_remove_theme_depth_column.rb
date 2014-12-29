class RemoveThemeDepthColumn < ActiveRecord::Migration
  def self.up
    remove_column :themes , :depth
  end

  def self.down
    add_column :themes , :depth , :integer , :limit => 1 , :default => 0 , :null => false
  end
end
