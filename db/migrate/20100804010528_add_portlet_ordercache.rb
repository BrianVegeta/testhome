class AddPortletOrdercache < ActiveRecord::Migration
  def self.up
    add_column :portlets , :ordercache , :string
  end

  def self.down
    remove_column :portlets , :ordercache
  end
end
