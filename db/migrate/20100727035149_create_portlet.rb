class ModuleSet < ActiveRecord::Base
end
class Portlet < ActiveRecord::Base
end
class CreatePortlet < ActiveRecord::Migration
  def self.up
    create_table "portlets", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_id" #對象 null = 全站
      t.integer  "module_set_id" #對象 null = 全站
      t.integer  "kind",                 :limit => 1, :default => 0,     :null => false #種類
      t.string   "name" #名稱
      t.text     "configure" #設定檔 #hash
      t.integer  "position"#排序
      t.integer  "showon",        :limit => 1#模版位置
      t.string   "title"#模版標題
      t.integer  "show_item_count",        :limit => 3, :default => 5,     :null => false#顯示portlet物件個數
      t.integer  "theme_kind",   :limit => 1, :default => 0,     :null => false#外觀類型
      t.integer  "display_kind", :limit => 1, :default => 0,     :null => false#顯示類型
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "showon_kind", :limit => 1, :default => nil #顯示於 nil = 全部，0=使用portlet_display，其餘參照model
      t.integer  :addon_site , :limit => 1 , :default => nil
    end
    create_table "portlet_displays", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "portlet_id"
      t.integer  "module_set_id"
      t.integer  "kind" #特殊顯示，免module_set_id "首頁 / "
    end

    ###轉換
    ModuleSet.all(:conditions => ["portlet_index IS NOT NULL OR portlet_position IS NOT NULL"]).each do |module_set|
      if module_set.kind > 100
        #如果為模組 => 新增
        Portlet.new(:organization_id => module_set.organization_id,
          #:module_set_id => module_set.id, #must be null
          :kind => module_set.kind - 100,
          :name => module_set.portlet_title,
          :configure => module_set.configure,
          :position => module_set.portlet_position,
          :showon => module_set.portlet_index,
          :display_kind => module_set.display_kind_portlet,
          :theme_kind => module_set.theme_kind_portlet,
          :addon_site => module_set.addon_site
        ).save
        module_set.destroy
      else
        #如果為模版 => 移動
        Portlet.new(:organization_id => module_set.organization_id,
          :module_set_id => module_set.id,
          :kind => module_set.kind,
          :name => module_set.portlet_title,
          :configure => module_set.configure,
          :position => module_set.portlet_position,
          :showon => module_set.portlet_index,
          :display_kind => module_set.display_kind_portlet,
          :theme_kind => module_set.theme_kind_portlet,
          :addon_site => module_set.addon_site
        ).save
      end
    end
    ###轉換
    remove_column :module_sets , "count_portlet"
    remove_column :module_sets , "display_in" #改用 portlet_displays
    remove_column :module_sets , "theme_kind_portlet"
    remove_column :module_sets , "display_kind_portlet"
    remove_column :module_sets , "portlet_index"
    remove_column :module_sets , "portlet_position"
    remove_column :module_sets , "portlet_title"
    remove_column :module_sets , :adgroup_id #改為portlet.configure
    remove_column :module_sets , :is_public #無用
    remove_column :module_sets , "permission_kind"
    change_column :module_sets , :kind , :integer , :limit => 1, :default => 0,     :null => false #種類
  end
  def self.down
    #just for test.down
    drop_table "portlets"
    drop_table "portlet_displays"
    add_column :module_sets , "count_portlet" , :integer
    add_column :module_sets , "display_in" , :integer #改用 portlet_displays
    add_column :module_sets , "theme_kind_portlet" , :integer
    add_column :module_sets , "display_kind_portlet" , :integer
    add_column :module_sets , "portlet_index" , :integer
    add_column :module_sets , "portlet_position" , :integer
    add_column :module_sets , "portlet_title" , :string
    add_column :module_sets , :adgroup_id , :integer #改為portlet.configure
    add_column :module_sets , :is_public , :integer #無用
    add_column :module_sets , "permission_kind" , :integer
    change_column :module_sets , :kind , :integer , :limit => 1, :default => 0,     :null => false #種類
  end
end
