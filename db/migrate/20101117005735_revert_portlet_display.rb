class PortletDisplay < ActiveRecord::Base
end
class RevertPortletDisplay < ActiveRecord::Migration
  def self.up
    #刪除個人頁，因此刪除3，4 => 3 , 5 => 4
    PortletDisplay.delete_all("kind = 3")
    PortletDisplay.update_all("kind = 3" , "kind = 4")
    PortletDisplay.update_all("kind = 4" , "kind = 5")
  end

  def self.down
    #3=>4 , 4=>5
    PortletDisplay.update_all("kind = 5" , "kind = 4")
    PortletDisplay.update_all("kind = 4" , "kind = 3")
  end
end
