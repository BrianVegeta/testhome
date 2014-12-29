class FixAdgroupDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :adgroups , :width , :integer , :limit => 2 ,:default => 180 , :null => false
    change_column :adgroups , :height , :integer , :limit => 2 , :default => 180 , :null => false
  end
  def self.down
    change_column :adgroups , :width , :integer , :limit => 2 , :default => nil , :null => true
    change_column :adgroups , :height , :integer , :limit => 2 , :default => nil , :null => true
  end
end
