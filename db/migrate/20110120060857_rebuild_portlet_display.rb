class Portlet < ActiveRecord::Base ; end
class PortletDisplay < ActiveRecord::Base ; end
class ModuleSet < ActiveRecord::Base ; end
#[["首頁",0],["搜尋",1],["物件",2],["區域討論",3],["個人頁",4]] 0..4

class RebuildPortletDisplay < ActiveRecord::Migration
  def self.up
    #remove addon_site
    Portlet.delete_all("addon_site IS NOT NULL")
    ModuleSet.delete_all("addon_site IS NOT NULL")

    remove_index :portlets , :name => "addon_site"
    remove_index :module_sets , :name => "addon_site"
    remove_column :portlets , :addon_site
    remove_column :module_sets , :addon_site

    add_column :portlet_displays , :position , :integer
    add_column :portlet_displays , :showon , :integer , :limit => 1 , :default => 0 , :null => false

    add_column :portlet_displays , :name , :string #allow null => portlet source
    add_column :portlet_displays , :theme_kind , :integer , :limit => 1 #allow null => portlet source
    add_column :portlet_displays , :display_kind , :integer , :limit => 1 #allow null => portlet source
    add_column :portlet_displays , :show_item_count , :integer , :limit => 2 #allow null => portlet source
    add_column :portlet_displays , :organization_id , :integer

    #策略：
    #1.新增所有null的portlet_display(portlet_displays_count = 0)
    #2.因為當portlet_displays的value為null，會去抓portlet的value，因此不用填入任何資料，因此只要把link新增出來即可
    #3.綜合以上，只新增目前沒有的部分

    #重新設定module_set.kind => portlet.kind快取，kind基本上是永久不變的
    ActiveRecord::Base.connection.execute("UPDATE portlets LEFT JOIN module_sets ON portlets.module_set_id = module_sets.id SET portlets.kind = module_sets.kind WHERE portlets.module_set_id IS NOT NULL")

    #change
    #portlet t.integer  "show_item_count",        :limit => 3,    :default => 5,            :null => false
    change_column :portlets , :show_item_count , :integer , :limit => 2 , :default => 5 , :null => false
    change_column :portlets , :name , :string , :null => false

    Portlet.all(:conditions => "showon IS NOT NULL" , :order => "position , id").each do |portlet|
      if PortletDisplay.count(:conditions => "portlet_id = #{portlet.id}") == 0 #無指定
        portlet.update_attribute("name" , ModuleSet.find(portlet.module_set_id).name) if (portlet.name.nil? || portlet.name.length == 0) && portlet.module_set_id
        target_kind  = [nil] + (0..4).to_a
        #kind <=>module_set_id
        target_kind.each do |target|
          if target #kind
            PortletDisplay.new(:portlet_id => portlet.id , :organization_id => portlet.organization_id , :module_set_id => nil , :kind => target , :showon => portlet.showon , :position => portlet.position).save
          else #module_set
            #nil為全站，非nil為org
            ModuleSet.all(:conditions => "organization_id #{portlet.organization_id ? "= #{portlet.organization_id}" : "IS NULL"}").each do |module_set|
              PortletDisplay.new(:portlet_id => portlet.id , :module_set_id => module_set.id , :organization_id => portlet.organization_id || module_set.organization_id , :kind => nil , :showon => portlet.showon , :position => portlet.position).save
            end
          end
        end
      else #已有指定(rebuild)
        PortletDisplay.update_all("showon = #{portlet.showon} , position = #{portlet.position ? portlet.position : "NULL"}" , "portlet_id = #{portlet.id}")
      end
    end
    #清除垃圾：portlet.showon => null 但有PortletDisplay
    Portlet.all(:conditions => "showon IS NULL").each do |portlet|
      PortletDisplay.delete_all("portlet_id = #{portlet.id}")
    end
    #清除禁用之輔助欄之欄位
    #刪除資料夾模組的顯示
    PortletDisplay.delete_all("showon = 2 AND (kind = 1 OR kind = 2 OR kind = 4)")
    ModuleSet.all(:conditions => "kind = 0").each do |module_set|
      PortletDisplay.delete_all("module_set_id = #{module_set.id}")
    end
    #刪除自定系右欄(固定不會顯示)
    ModuleSet.all(:conditions => "kind = 5 OR kind = 7").each do |module_set|
      PortletDisplay.delete_all("module_set_id = #{module_set.id} AND showon = 2")
    end
    #刪除已關閉之欄位模組
    ModuleSet.all(:conditions => "display_column > 0").each do |module_set|
      if module_set.display_column == 1 || module_set.display_column == 3
        #del R
        PortletDisplay.delete_all("module_set_id = #{module_set.id} AND showon = 2")
      end
      if module_set.display_column == 2 || module_set.display_column == 3
        PortletDisplay.delete_all("module_set_id = #{module_set.id} AND showon = 0")
      end
    end

    #clear
    remove_column :portlets , :showon
    remove_column :portlets , :portlet_displays_count #刪除count，因之前為count = 0 => all



    #reorder all PortletDisplay => "position DESC , id" to "position DESC , id DESC"
    #make all portlet_display has position
    #has position + no_position.count , no_position.position = index

    Portlet.all(:select => "id").each do |portlet|
      no_position_pd = PortletDisplay.all(:conditions => ["portlet_id = ? AND position IS NULL" , portlet.id] , :order => "id DESC")
      PortletDisplay.update_all("position = position + #{no_position_pd.length}" , "portlet_id = #{portlet.id} AND position IS NOT NULL")
      no_position_pd.each_index do |i|
        no_position_pd[i].update_attribute("position" , i)
      end
    end

    ActiveRecord::Base.connection.execute("UPDATE portlet_displays LEFT JOIN portlets ON portlet_displays.portlet_id = portlets.id SET portlet_displays.organization_id = portlets.organization_id")

    #portlet , module_set keep old sort
  end

  def self.down
    make_error
  end
end
