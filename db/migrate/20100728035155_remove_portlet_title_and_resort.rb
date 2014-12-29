class ModuleSet < ActiveRecord::Base
end
class Portlet < ActiveRecord::Base
end
class RemovePortletTitleAndResort < ActiveRecord::Migration
  def self.up
    Portlet.all.each do |portlet|
      if portlet.showon.nil? || portlet.showon <= 2
        portlet.update_attribute("name" , "#{portlet.name}#{portlet.title}" )
      else
        portlet.update_attributes(:name => "#{portlet.name}#{portlet.title}" , :showon => nil)
      end
    end
    remove_column :portlets , :title
    ModuleSet.delete_all("kind > 20 AND kind < 100")
    #from : [["標籤雲" , 1],["最新物件" , 2],["精選物件" ,3] , ["隨機物件" , 4] , ["物件軌跡" , 5] , ["搜尋" , 6] , ["社群討論" , 7] , ["廣告欄位" , 8] , ["GoogleAD" , 9]]
    #to   : [["標籤雲" , 0],["物件列表" , 1],["物件種類" ,2] , ["物件軌跡" , 3] , ["搜尋" , 4] , ["社群討論" , 5] , ["廣告欄位" , 6] , ["GoogleAD" , 7]]
    # 3 => 2 ; 4 => 2

    Portlet.all(:conditions => "kind = 3 OR kind = 4").each do |portlet|
      portlet.update_attribute("kind" , 2)
    end

    Portlet.all.each do |portlet|
      portlet.update_attribute("kind" , portlet.kind - 1)
    end

    #can't reversion
  end

  def self.down
    #make_error
    add_column :portlets , :title , :string
  end
end
