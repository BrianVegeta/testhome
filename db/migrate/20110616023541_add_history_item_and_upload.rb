class AddHistoryItemAndUpload < ActiveRecord::Migration
  def self.up
    create_table "history_items", :force => true do |t|
      t.string   "type",               :limit => 30
      t.integer  "owner_id",                                                                                  :null => false
      t.string   "owner_type",                                                                                :null => false
      t.integer  "cover_id"
      t.integer  "position"
      t.integer  "sale_kind",          :limit => 1,                                 :default => 0,            :null => false
      t.integer  "main_area",          :limit => 1,                                                           :null => false
      t.integer  "sub_area",           :limit => 1,                                                           :null => false
      t.string   "name",                                                                                      :null => false
      t.string   "unique_number"
      t.integer  "emoticons",          :limit => 1
      t.boolean  "accessories",                                                     :default => true,         :null => false
      t.integer  "sales_status",       :limit => 1,                                 :default => 0,            :null => false
      t.boolean  "featured",                                                        :default => false,        :null => false
      t.string   "road_name"
      t.string   "house_number"
      t.integer  "total_price",        :limit => 10, :precision => 10, :scale => 0, :default => 0,            :null => false
      t.integer  "per_price",          :limit => 10, :precision => 10, :scale => 0, :default => 0,            :null => false
      t.integer  "addon_price",        :limit => 10, :precision => 10, :scale => 0, :default => 0,            :null => false
      t.integer  "solds",              :limit => 1,                                 :default => 0,            :null => false
      t.integer  "direction",          :limit => 1
      t.integer  "old",                :limit => 2
      t.integer  "upfloor",            :limit => 1
      t.integer  "downfloor",          :limit => 1
      t.text     "floor_select"
      t.text     "floor_room_number"
      t.integer  "pattern_room",       :limit => 1,                                 :default => 0,            :null => false
      t.integer  "pattern_living",     :limit => 1,                                 :default => 0,            :null => false
      t.integer  "pattern_bath",       :limit => 1,                                 :default => 0,            :null => false
      t.float    "amount"
      t.float    "public_amount"
      t.float    "inner_amount"
      t.float    "addon_amount"
      t.float    "land_amount"
      t.float    "hold_amount"
      t.integer  "land_kind",                                                       :default => 0,            :null => false
      t.integer  "molecular"
      t.integer  "denominator"
      t.boolean  "is_distribution"
      t.string   "appearance"
      t.string   "materials"
      t.string   "wide"
      t.string   "road_wide"
      t.string   "house_status"
      t.string   "school"
      t.string   "market"
      t.string   "park"
      t.string   "mrt"
      t.text     "descript"
      t.string   "remarks"
      t.string   "parking"
      t.integer  "management_fees"
      t.integer  "management_fees_by"
      t.datetime "end_at"
      t.boolean  "has_addon",                                                       :default => false,        :null => false
      t.float    "depth"
      t.integer  "land_bcr"
      t.integer  "land_far"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "lft"
      t.integer  "recommand_count"
      t.integer  "share",              :limit => 1,                                 :default => 0,            :null => false
      t.boolean  "share_sales",                                                     :default => false,        :null => false
      t.text     "relation_lft"
      t.text     "search_cache"
      t.string   "build_company"
      t.float    "another_amount"
      t.integer  "household",          :limit => 1
      t.integer  "loan_fees"
      t.integer  "another_fees"
      t.datetime "solds_time"
      t.string   "property",           :limit => 70,                                :default => "--- []\n\n", :null => false
      t.integer  "management_way",     :limit => 1
      t.integer  "old_id"
      t.boolean  "old_map_error"
      t.float    "parking_amount"
      t.boolean  "old_downloaded",                                                  :default => false
      t.boolean  "old_maped",                                                       :default => false
      t.boolean  "is_org_close",                                                    :default => false,        :null => false
      t.integer  "pattern_room_plus",  :limit => 1,                                 :default => 0,            :null => false
      t.float    "lng"
      t.float    "lat"
      t.integer  "zoom",               :limit => 1
      t.float    "yaw"
      t.float    "pitch"
      t.boolean  "auto_find"
      t.integer  "old_year",           :limit => 2
      t.integer  "old_month",          :limit => 1
    end
    create_table "history_item_uploads", :force => true do |t|
      t.integer  "owner_id"
      t.string   "owner_type",        :limit => 30
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "type"
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.integer  "old_id"
      t.string   "temp_key",          :limit => 40
      t.boolean  "locked"
      t.integer  "parent_id"
      t.integer  "cover_id"
      t.string   "file_fingerprint",  :limit => 32
    end
  end

  def self.down
    drop_table "history_items"
    drop_table "history_item_uploads"
  end
end
