class HideOrgAndPortletMenuSortSelect < ActiveRecord::Migration
  def self.up
    add_column :organizations , :hide_header , :boolean
    add_column :organizations , :sort_portlet_column , :integer , :limit => 1 , :default => 0 , :null => false
  end

  def self.down
    remove_column :organizations , :hide_header
    remove_column :organizations , :sort_portlet_column
  end
end
