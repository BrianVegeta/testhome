class AddExhibitAndAddGlobalSettingIndex < ActiveRecord::Migration
  def self.up
    create_table "exhibits", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" #null => main site
      t.string  "name", :null => false
      t.integer "kind" , :limit => 1 , :null => false
      t.integer "module_set_id"
      t.integer "adgroup_id"
      t.integer "position"
      t.text    "configure" , :limit => 2000
      t.text    "body" , :limit => 2000
      t.boolean "hidden" , :null => false , :default => false
      t.integer "order_by" , :limit => 1 , :null => false , :default => 0
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "exhibits", ["organization_id"], :name => "index_pads_organization_id"
    add_index "exhibits", ["module_set_id"], :name => "index_pads_module_set_id"
    ##theme & is use exhibit
    add_column "organizations" , "exhibit" , :integer , :limit => 1 , :null => false , :default => 0
    add_column "organizations" , "exhibit_theme" , :integer , :limit => 1 , :null => false , :default => 0
    
    add_index "global_settings" , ["name"], :name => "global_settings_name"
  end

  def self.down
    drop_table "exhibits"
    remove_column "organizations" , "exhibit"
    remove_column "organizations" , "exhibit_theme"
    
    remove_index "global_settings" , :name => "global_settings_name"
  end
end
