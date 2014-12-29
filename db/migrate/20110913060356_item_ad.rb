class ItemAd < ActiveRecord::Migration
  def self.up
    add_column "organizations" , "show_item_ad" , :boolean , :default => false , :null => false
    
    create_table "item_ads", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" #null => main site
      t.integer "item_id", :null => false
      t.integer "position"
      t.integer "kind" , :limit => 1 , :null => false , :default => 0 #0=顯示 , 1=使用end_at , 2=隱藏
      t.date "end_at" #儲存於
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "item_ads", ["organization_id"], :name => "item_ads_organization_id"
    add_index "item_ads", ["item_id"], :name => "item_ads_item_id"
    add_index "item_ads", ["end_at"], :name => "item_ads_end_at"
  end

  def self.down
    remove_column "organizations" , "show_item_ad"
    
    drop_table "item_ads"
  end
end
