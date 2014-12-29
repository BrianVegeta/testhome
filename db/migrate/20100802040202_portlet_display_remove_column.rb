class PortletDisplayRemoveColumn < ActiveRecord::Migration
  def self.up
    remove_column :portlet_displays , :organization_id
    remove_column :portlet_displays , :showon
  end

  def self.down
    add_column :portlet_displays , :organization_id  , :integer
    add_column :portlet_displays , :showon , :integer , :limit => 1
  end
end