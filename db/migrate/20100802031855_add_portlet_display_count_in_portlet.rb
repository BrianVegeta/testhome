class Portlet < ActiveRecord::Base
end
class PortletDisplay < ActiveRecord::Base
end
class AddPortletDisplayCountInPortlet < ActiveRecord::Migration
  def self.up
    add_column :portlets , :portlet_displays_count , :integer , :default => 0 , :null => false
    Portlet.all.each do |portlet|
      portlet.update_attribute("portlet_displays_count" , PortletDisplay.count(:conditions => ["portlet_id = ?" , portlet.id]))
    end
  end

  def self.down
    remove_column :portlets , :portlet_displays_count
  end
end
