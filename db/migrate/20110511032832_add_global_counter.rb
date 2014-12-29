class AddGlobalCounter < ActiveRecord::Migration
  def self.up
    #不使用"count"這個column , 而使用"total"
    create_table "global_settings", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string "name" , :null => false
      t.integer "kind" , :limit => 1
      t.integer "value_int"
      t.string "value_str"
      t.datetime "value_date"
      t.datetime "created_at" , :null => false
      t.datetime "updated_at" , :null => false
    end
    create_table "counter_targets", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "owner_id" , :null => false
      t.string   "owner_type", :limit => 30 , :null => false
      t.integer  "total" , :null => false , :default => 0 #total = count details of day
      t.datetime "created_at" , :null => false
    end
    add_index "counter_targets", ["owner_id","owner_type"], :name => "owner_id_owner_type", :unique => true
    create_table "counter_years", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "counter_target_id" , :null => false
      t.integer  "total" , :null => false , :default => 0 #total = count details of day
      t.date     "date"  , :null => false
    end
    add_index "counter_years", ["counter_target_id"], :name => "counter_target_id"
    add_index "counter_years", ["date"], :name => "date"
    add_index "counter_years", ["counter_target_id" , "date"], :name => "counter_target_id_date", :unique => true
    
    create_table "counter_months", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "counter_target_id" , :null => false
      t.integer  "total" , :null => false , :default => 0 #total = count details of day
      t.date     "date"  , :null => false
    end
    add_index "counter_months", ["counter_target_id"], :name => "counter_target_id"
    add_index "counter_months", ["date"], :name => "date"
    add_index "counter_months", ["counter_target_id" , "date"], :name => "counter_target_id_date", :unique => true
    
    create_table "counter_days", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "counter_target_id" , :null => false
      t.integer  "total" , :null => false , :default => 0 #total = count details of day
      t.date     "date"  , :null => false
    end
    add_index "counter_days", ["counter_target_id"], :name => "counter_target_id"
    add_index "counter_days", ["date"], :name => "date"
    add_index "counter_days", ["counter_target_id" , "date"], :name => "counter_target_id_date", :unique => true
  end

  def self.down
    drop_table "global_settings"
    drop_table "counter_targets"
    drop_table "counter_years"
    drop_table "counter_months"
    drop_table "counter_days"
  end
end