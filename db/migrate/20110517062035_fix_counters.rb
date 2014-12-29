class FixCounters < ActiveRecord::Migration
  def self.up
    drop_table "counter_days"
    drop_table "counter_months"
    drop_table "counter_years"
    drop_table "counter_targets"

    create_table "counter_days", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "total",                 :default => 0, :null => false
      t.date    "date",                                 :null => false
      t.integer "owner_id",                             :null => false
      t.integer "kind",     :limit => 1,                :null => false
    end
    add_index "counter_days", ["date"], :name => "date"
    add_index "counter_days", ["owner_id"], :name => "owner_id"
    add_index "counter_days", ["kind"], :name => "kind"
    add_index "counter_days", ["date" , "owner_id" , "kind"], :name => "date_owner_id_kind", :unique => true

    create_table "counter_months", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "total",                 :default => 0, :null => false
      t.date    "date",                                 :null => false
      t.integer "owner_id",                             :null => false
      t.integer "kind",     :limit => 1,                :null => false
    end
    add_index "counter_months", ["date"], :name => "date"
    add_index "counter_months", ["owner_id"], :name => "owner_id"
    add_index "counter_months", ["kind"], :name => "kind"
    add_index "counter_months", ["date" , "owner_id" , "kind"], :name => "date_owner_id_kind", :unique => true

    create_table "counter_targets", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "total",                   :default => 0, :null => false
      t.datetime "created_at",                             :null => false
      t.integer  "owner_id",                               :null => false
      t.integer  "kind",       :limit => 1,                :null => false
    end
    add_index "counter_targets", ["owner_id"], :name => "owner_id"
    add_index "counter_targets", ["kind"], :name => "kind"
    add_index "counter_targets", ["owner_id" , "kind"], :name => "date_owner_id_kind", :unique => true

    create_table "counter_years", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "total",                 :default => 0, :null => false
      t.date    "date",                                 :null => false
      t.integer "owner_id",                             :null => false
      t.integer "kind",     :limit => 1,                :null => false
    end
    add_index "counter_years", ["date"], :name => "date"
    add_index "counter_years", ["owner_id"], :name => "owner_id"
    add_index "counter_years", ["kind"], :name => "kind"
    add_index "counter_years", ["date" , "owner_id" , "kind"], :name => "date_owner_id_kind", :unique => true

  end
  def self.down
  end
end
