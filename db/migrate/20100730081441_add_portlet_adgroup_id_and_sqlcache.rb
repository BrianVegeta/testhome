class AddPortletAdgroupIdAndSqlcache < ActiveRecord::Migration
  def self.up
    add_column :portlets , :adgroup_id , :integer
    add_column :portlets , :sqlcache , :text , :limit => 3000
  end

  def self.down
    remove_column :portlets , :adgroup_id
    remove_column :portlets , :sqlcache
  end
end
