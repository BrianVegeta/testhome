class FixDoaminDefaultKind < ActiveRecord::Migration
  def self.up
    change_column :domains , "kind", :integer ,  :limit => 1, :default => 1, :null => false
  end

  def self.down
    change_column :domains , "kind", :integer ,  :limit => 1, :default => 0, :null => false
  end
end
