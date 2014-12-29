class FixOrgKindColumn < ActiveRecord::Migration
  def self.up
    change_column :organizations , :kind , :integer , :limit => 1 , :default => 0 , :null => false
  end

  def self.down
    change_column :organizations , :kind , :integer , :limit => 1 , :default => nil , :null => true
  end
end
