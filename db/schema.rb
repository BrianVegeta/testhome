# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150121100359) do

  create_table "adgroups", force: true do |t|
    t.integer  "organization_id"
    t.string   "name",                                    null: false
    t.integer  "width",           limit: 2, default: 180, null: false
    t.integer  "height",          limit: 2, default: 180, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adgroups", ["organization_id"], name: "adgroup_organization_id", using: :btree

  create_table "adrands", force: true do |t|
    t.integer "ad_id",           null: false
    t.integer "adgroup_id"
    t.integer "organization_id"
    t.string  "file_file_name",  null: false
    t.string  "name",            null: false
    t.string  "url",             null: false
  end

  add_index "adrands", ["ad_id"], name: "ad_id", using: :btree
  add_index "adrands", ["adgroup_id", "organization_id"], name: "adrands_adgroup_id_organization_id", using: :btree
  add_index "adrands", ["adgroup_id"], name: "adgroup_id", using: :btree
  add_index "adrands", ["organization_id"], name: "organization_id", using: :btree

  create_table "ads", force: true do |t|
    t.integer  "adgroup_id"
    t.string   "name",                                    null: false
    t.string   "file_file_name",                          null: false
    t.string   "file_content_type",                       null: false
    t.integer  "file_file_size",                          null: false
    t.integer  "priority",          limit: 1, default: 0, null: false
    t.string   "url",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "ads", ["adgroup_id"], name: "ad_adgroup_id", using: :btree
  add_index "ads", ["organization_id"], name: "organization_id", using: :btree

  create_table "area_roads", force: true do |t|
    t.integer "main_area", limit: 1, null: false
    t.integer "sub_area",  limit: 1, null: false
    t.string  "road",                null: false
  end

  add_index "area_roads", ["main_area", "sub_area"], name: "main_area_sub_area", using: :btree

  create_table "areas", force: true do |t|
    t.string  "name",                null: false
    t.integer "main_area", limit: 1, null: false
    t.integer "sub_area",  limit: 1, null: false
  end

  add_index "areas", ["main_area", "sub_area"], name: "main_area_sub_area", using: :btree

  create_table "black_members", force: true do |t|
    t.integer  "organization_id",               null: false
    t.string   "from"
    t.text     "title"
    t.text     "body"
    t.string   "name"
    t.string   "identity"
    t.integer  "main_area"
    t.integer  "sub_area"
    t.string   "address"
    t.string   "sales_id"
    t.string   "agent_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "photo_fingerprint",  limit: 32
    t.datetime "report_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                       null: false
  end

  add_index "black_members", ["identity"], name: "black_members_identity", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "type",         limit: 30
    t.integer  "owner_id"
    t.string   "owner_type",   limit: 30
    t.integer  "user_id"
    t.integer  "cover_id"
    t.string   "title"
    t.string   "descript"
    t.text     "body",         limit: 2147483647
    t.text     "content",      limit: 2147483647
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "search_cache"
    t.boolean  "signed",                          default: false, null: false
    t.boolean  "hidden",                          default: false, null: false
    t.boolean  "is_zombie",                       default: false, null: false
    t.integer  "level",        limit: 1,          default: 0,     null: false
    t.date     "end_at"
  end

  add_index "blogs", ["end_at"], name: "blogs_end_at", using: :btree
  add_index "blogs", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree
  add_index "blogs", ["type"], name: "type", using: :btree
  add_index "blogs", ["user_id"], name: "user_id", using: :btree

  create_table "books", force: true do |t|
    t.integer  "module_set_id",                                  null: false
    t.integer  "cover_id"
    t.integer  "position"
    t.string   "title",                                          null: false
    t.text     "descript"
    t.integer  "width",         limit: 2, default: 384,          null: false
    t.integer  "height",        limit: 2, default: 512,          null: false
    t.integer  "cc",            limit: 1, default: 0,            null: false
    t.boolean  "hidden",                  default: false,        null: false
    t.integer  "start_page",    limit: 2, default: 1,            null: false
    t.integer  "zoom",          limit: 1, default: 2,            null: false
    t.string   "options",                 default: "--- {}\n\n", null: false
    t.integer  "pages_count",             default: 0,            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["cover_id"], name: "books_cover_id", using: :btree
  add_index "books", ["module_set_id"], name: "books_module_set_id", using: :btree

  create_table "commerce_areas", force: true do |t|
    t.integer "organization_id",           null: false
    t.integer "main_area",       limit: 1, null: false
  end

  add_index "commerce_areas", ["main_area"], name: "commerce_areas_main_area", using: :btree
  add_index "commerce_areas", ["organization_id", "main_area"], name: "commerce_areas_organization_id_main_area", unique: true, using: :btree
  add_index "commerce_areas", ["organization_id"], name: "commerce_areas_organization_id", using: :btree

  create_table "commissions", force: true do |t|
    t.string   "owner_type"
    t.integer  "owner_id"
    t.integer  "kind",       limit: 1, default: 0, null: false
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main",       limit: 1, default: 0, null: false
    t.integer  "from_id",                          null: false
    t.string   "from_type",                        null: false
    t.integer  "value",      limit: 2,             null: false
    t.integer  "sub",        limit: 1, default: 0, null: false
  end

  add_index "commissions", ["end_at"], name: "end_at", using: :btree
  add_index "commissions", ["from_id"], name: "from_id", using: :btree
  add_index "commissions", ["from_type"], name: "from_type", using: :btree
  add_index "commissions", ["main"], name: "main", using: :btree
  add_index "commissions", ["owner_id"], name: "owner_id", using: :btree
  add_index "commissions", ["owner_type"], name: "owner_type", using: :btree
  add_index "commissions", ["sub"], name: "sub", using: :btree

  create_table "counter_days", force: true do |t|
    t.integer "total",              default: 0, null: false
    t.date    "date",                           null: false
    t.integer "owner_id",                       null: false
    t.integer "kind",     limit: 1,             null: false
  end

  add_index "counter_days", ["date", "owner_id", "kind"], name: "date_owner_id_kind", unique: true, using: :btree
  add_index "counter_days", ["date"], name: "date", using: :btree
  add_index "counter_days", ["kind"], name: "kind", using: :btree
  add_index "counter_days", ["owner_id"], name: "owner_id", using: :btree

  create_table "counter_months", force: true do |t|
    t.integer "total",              default: 0, null: false
    t.date    "date",                           null: false
    t.integer "owner_id",                       null: false
    t.integer "kind",     limit: 1,             null: false
  end

  add_index "counter_months", ["date", "owner_id", "kind"], name: "date_owner_id_kind", unique: true, using: :btree
  add_index "counter_months", ["date"], name: "date", using: :btree
  add_index "counter_months", ["kind"], name: "kind", using: :btree
  add_index "counter_months", ["owner_id"], name: "owner_id", using: :btree

  create_table "counter_targets", force: true do |t|
    t.integer  "total",                default: 0, null: false
    t.datetime "created_at",                       null: false
    t.integer  "owner_id",                         null: false
    t.integer  "kind",       limit: 1,             null: false
  end

  add_index "counter_targets", ["kind"], name: "kind", using: :btree
  add_index "counter_targets", ["owner_id", "kind"], name: "date_owner_id_kind", unique: true, using: :btree
  add_index "counter_targets", ["owner_id"], name: "owner_id", using: :btree

  create_table "counter_years", force: true do |t|
    t.integer "total",              default: 0, null: false
    t.date    "date",                           null: false
    t.integer "owner_id",                       null: false
    t.integer "kind",     limit: 1,             null: false
  end

  add_index "counter_years", ["date", "owner_id", "kind"], name: "date_owner_id_kind", unique: true, using: :btree
  add_index "counter_years", ["date"], name: "date", using: :btree
  add_index "counter_years", ["kind"], name: "kind", using: :btree
  add_index "counter_years", ["owner_id"], name: "owner_id", using: :btree

  create_table "domain_checkers", force: true do |t|
    t.string   "domain_name",                                   null: false
    t.string   "punycoded_domain_name",                         null: false
    t.string   "account"
    t.string   "descript"
    t.text     "info"
    t.integer  "register_vendors",      limit: 1,   default: 0, null: false
    t.integer  "dns_vendors",           limit: 1,   default: 0, null: false
    t.string   "salt",                                          null: false
    t.string   "password",              limit: 512,             null: false
    t.integer  "status",                limit: 1,   default: 0, null: false
    t.date     "record_expired_at",                             null: false
    t.date     "record_created_at",                             null: false
    t.datetime "created_at",                                    null: false
    t.datetime "scaned_at",                                     null: false
  end

  add_index "domain_checkers", ["record_expired_at"], name: "domain_checkers_record_expired_at", using: :btree

  create_table "domains", force: true do |t|
    t.integer  "organization_id",                       null: false
    t.string   "name",                                  null: false
    t.integer  "kind",            limit: 1, default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
    t.string   "ori_name",                              null: false
  end

  add_index "domains", ["name", "kind"], name: "domain_name_index", unique: true, using: :btree
  add_index "domains", ["organization_id"], name: "organization_id", using: :btree

  create_table "exhibits", force: true do |t|
    t.integer  "organization_id"
    t.string   "name",                                      null: false
    t.integer  "kind",            limit: 1,                 null: false
    t.integer  "module_set_id"
    t.integer  "adgroup_id"
    t.integer  "position"
    t.text     "configure"
    t.text     "body"
    t.boolean  "hidden",                    default: false, null: false
    t.integer  "order_by",        limit: 1, default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exhibits", ["module_set_id"], name: "index_pads_module_set_id", using: :btree
  add_index "exhibits", ["organization_id"], name: "index_pads_organization_id", using: :btree

  create_table "global_settings", force: true do |t|
    t.string   "name",                 null: false
    t.integer  "kind",       limit: 1
    t.integer  "value_int"
    t.string   "value_str"
    t.datetime "value_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "global_settings", ["name"], name: "global_settings_name", using: :btree

  create_table "headquarters", force: true do |t|
    t.integer "organization_id", null: false
    t.integer "child_id",        null: false
  end

  add_index "headquarters", ["organization_id", "child_id"], name: "organization_child_id", unique: true, using: :btree

  create_table "history_item_uploads", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type",        limit: 30
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.integer  "old_id"
    t.string   "temp_key",          limit: 40
    t.boolean  "locked"
    t.integer  "parent_id"
    t.integer  "cover_id"
    t.string   "file_fingerprint",  limit: 32
  end

  create_table "history_items", force: true do |t|
    t.string   "type",               limit: 30
    t.integer  "owner_id",                                             null: false
    t.string   "owner_type",                                           null: false
    t.integer  "cover_id"
    t.integer  "position"
    t.integer  "sale_kind",          limit: 1,  default: 0,            null: false
    t.integer  "main_area",          limit: 1,                         null: false
    t.integer  "sub_area",           limit: 1,                         null: false
    t.string   "name",                                                 null: false
    t.string   "unique_number"
    t.integer  "emoticons",          limit: 1
    t.boolean  "accessories",                   default: true,         null: false
    t.integer  "sales_status",       limit: 1,  default: 0,            null: false
    t.boolean  "featured",                      default: false,        null: false
    t.string   "road_name"
    t.string   "house_number"
    t.integer  "total_price",                   default: 0,            null: false
    t.integer  "per_price",                     default: 0,            null: false
    t.integer  "addon_price",                   default: 0,            null: false
    t.integer  "solds",              limit: 1,  default: 0,            null: false
    t.integer  "direction",          limit: 1
    t.integer  "old",                limit: 2
    t.integer  "upfloor",            limit: 1
    t.integer  "downfloor",          limit: 1
    t.text     "floor_select"
    t.text     "floor_room_number"
    t.integer  "pattern_room",       limit: 1,  default: 0,            null: false
    t.integer  "pattern_living",     limit: 1,  default: 0,            null: false
    t.integer  "pattern_bath",       limit: 1,  default: 0,            null: false
    t.float    "amount",             limit: 24
    t.float    "public_amount",      limit: 24
    t.float    "inner_amount",       limit: 24
    t.float    "addon_amount",       limit: 24
    t.float    "land_amount",        limit: 24
    t.float    "hold_amount",        limit: 24
    t.integer  "land_kind",                     default: 0,            null: false
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
    t.boolean  "has_addon",                     default: false,        null: false
    t.float    "depth",              limit: 24
    t.integer  "land_bcr"
    t.integer  "land_far"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "recommand_count"
    t.integer  "share",              limit: 1,  default: 0,            null: false
    t.boolean  "share_sales",                   default: false,        null: false
    t.text     "relation_lft"
    t.text     "search_cache"
    t.string   "build_company"
    t.float    "another_amount",     limit: 24
    t.integer  "household",          limit: 1
    t.integer  "loan_fees"
    t.integer  "another_fees"
    t.datetime "solds_time"
    t.string   "property",           limit: 70, default: "--- []\n\n", null: false
    t.integer  "management_way",     limit: 1
    t.integer  "old_id"
    t.boolean  "old_map_error"
    t.float    "parking_amount",     limit: 24
    t.boolean  "old_downloaded",                default: false
    t.boolean  "old_maped",                     default: false
    t.boolean  "is_org_close",                  default: false,        null: false
    t.integer  "pattern_room_plus",  limit: 1,  default: 0,            null: false
    t.float    "lng",                limit: 24
    t.float    "lat",                limit: 24
    t.integer  "zoom",               limit: 1
    t.float    "yaw",                limit: 24
    t.float    "pitch",              limit: 24
    t.boolean  "auto_find"
    t.integer  "old_year",           limit: 2
    t.integer  "old_month",          limit: 1
    t.boolean  "has_image",                     default: false,        null: false
  end

  create_table "item_ads", force: true do |t|
    t.integer  "organization_id"
    t.integer  "item_id",                               null: false
    t.integer  "position"
    t.integer  "kind",            limit: 1, default: 0, null: false
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_ads", ["end_at"], name: "item_ads_end_at", using: :btree
  add_index "item_ads", ["item_id"], name: "item_ads_item_id", using: :btree
  add_index "item_ads", ["organization_id"], name: "item_ads_organization_id", using: :btree

  create_table "item_alerms", force: true do |t|
    t.integer  "owner_id",                     null: false
    t.string   "owner_type",                   null: false
    t.integer  "item_flag_id",                 null: false
    t.boolean  "checked",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_alerms", ["item_flag_id"], name: "item_flag_id", using: :btree
  add_index "item_alerms", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree
  add_index "item_alerms", ["owner_id"], name: "owner_id", using: :btree
  add_index "item_alerms", ["owner_type"], name: "owner_type", using: :btree

  create_table "item_flags", force: true do |t|
    t.integer "user_id"
    t.integer "item_id",                                    null: false
    t.integer "kind",                                       null: false
    t.string  "title"
    t.text    "body"
    t.boolean "checked",                    default: false, null: false
    t.date    "start_at"
    t.date    "end_at"
    t.string  "request_ip",      limit: 15,                 null: false
    t.integer "organization_id"
  end

  add_index "item_flags", ["item_id", "kind"], name: "item_id_kind", using: :btree
  add_index "item_flags", ["item_id"], name: "item_id", using: :btree
  add_index "item_flags", ["user_id"], name: "user_id", using: :btree

  create_table "item_partakes", force: true do |t|
    t.integer  "organization_id",           null: false
    t.integer  "user_id",                   null: false
    t.integer  "item_id",                   null: false
    t.integer  "kind",            limit: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_partakes", ["item_id"], name: "item_id", using: :btree
  add_index "item_partakes", ["kind"], name: "kind", using: :btree
  add_index "item_partakes", ["organization_id"], name: "with_id_with_type", using: :btree
  add_index "item_partakes", ["user_id"], name: "target_id_target_type", using: :btree

  create_table "items", force: true do |t|
    t.string   "type",               limit: 30
    t.integer  "owner_id",                                                                      null: false
    t.string   "owner_type",                                                                    null: false
    t.integer  "cover_id"
    t.integer  "position"
    t.integer  "sale_kind",          limit: 1,                           default: 0,            null: false
    t.integer  "main_area",          limit: 1,                                                  null: false
    t.integer  "sub_area",           limit: 1,                                                  null: false
    t.string   "name",                                                                          null: false
    t.string   "unique_number"
    t.integer  "emoticons",          limit: 1
    t.boolean  "accessories",                                            default: true,         null: false
    t.integer  "sales_status",       limit: 1,                           default: 0,            null: false
    t.boolean  "featured",                                               default: false,        null: false
    t.string   "road_name"
    t.string   "house_number"
    t.decimal  "total_price",                   precision: 10, scale: 0, default: 0,            null: false
    t.decimal  "per_price",                     precision: 10, scale: 0, default: 0,            null: false
    t.decimal  "addon_price",                   precision: 10, scale: 0, default: 0,            null: false
    t.integer  "solds",              limit: 1,                           default: 0,            null: false
    t.integer  "direction",          limit: 1
    t.integer  "old",                limit: 2
    t.integer  "upfloor",            limit: 1
    t.integer  "downfloor",          limit: 1
    t.text     "floor_select"
    t.text     "floor_room_number"
    t.integer  "pattern_room",       limit: 1,                           default: 0,            null: false
    t.integer  "pattern_living",     limit: 1,                           default: 0,            null: false
    t.integer  "pattern_bath",       limit: 1,                           default: 0,            null: false
    t.float    "amount",             limit: 24
    t.float    "public_amount",      limit: 24
    t.float    "inner_amount",       limit: 24
    t.float    "addon_amount",       limit: 24
    t.float    "land_amount",        limit: 24
    t.float    "hold_amount",        limit: 24
    t.integer  "land_kind",                                              default: 0,            null: false
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
    t.boolean  "has_addon",                                              default: false,        null: false
    t.string   "depth"
    t.integer  "land_bcr"
    t.integer  "land_far"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lft"
    t.integer  "recommand_count"
    t.integer  "share",              limit: 1,                           default: 0,            null: false
    t.boolean  "share_sales",                                            default: false,        null: false
    t.text     "relation_lft"
    t.text     "search_cache"
    t.string   "build_company"
    t.float    "another_amount",     limit: 24
    t.integer  "household",          limit: 1
    t.integer  "loan_fees"
    t.integer  "another_fees"
    t.datetime "solds_time"
    t.string   "property",           limit: 70,                          default: "--- []\n\n", null: false
    t.integer  "management_way",     limit: 1
    t.integer  "old_id"
    t.boolean  "old_map_error"
    t.float    "parking_amount",     limit: 24
    t.boolean  "old_downloaded",                                         default: false
    t.boolean  "old_maped",                                              default: false
    t.boolean  "is_org_close",                                           default: false,        null: false
    t.integer  "pattern_room_plus",  limit: 1,                           default: 0,            null: false
    t.float    "lng",                limit: 53
    t.float    "lat",                limit: 53
    t.integer  "zoom",               limit: 1
    t.float    "yaw",                limit: 24
    t.float    "pitch",              limit: 24
    t.boolean  "auto_find"
    t.integer  "old_year",           limit: 2
    t.integer  "old_month",          limit: 1
    t.boolean  "has_image",                                              default: false,        null: false
  end

  add_index "items", ["accessories"], name: "accessories", using: :btree
  add_index "items", ["end_at"], name: "end_at", using: :btree
  add_index "items", ["is_org_close"], name: "is_org_close", using: :btree
  add_index "items", ["lat"], name: "items_lat", using: :btree
  add_index "items", ["lft"], name: "lft", using: :btree
  add_index "items", ["lng"], name: "items_lng", using: :btree
  add_index "items", ["main_area", "sub_area"], name: "main_area_sub_area", using: :btree
  add_index "items", ["main_area"], name: "main_area", using: :btree
  add_index "items", ["old_id"], name: "items_old_id", using: :btree
  add_index "items", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree
  add_index "items", ["owner_type"], name: "owner_type", using: :btree
  add_index "items", ["sale_kind"], name: "sale_kind", using: :btree
  add_index "items", ["type"], name: "type", using: :btree
  add_index "items", ["unique_number"], name: "unique_number", using: :btree

  create_table "join_requests", force: true do |t|
    t.string   "type",                               null: false
    t.string   "target_type",                        null: false
    t.integer  "target_id",                          null: false
    t.integer  "from_user_id"
    t.integer  "from_org_id"
    t.integer  "to_user_id"
    t.integer  "to_org_id"
    t.string   "maked_type"
    t.integer  "maked_id"
    t.integer  "status",       limit: 1, default: 0, null: false
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "join_requests", ["from_org_id"], name: "from_org_id", using: :btree
  add_index "join_requests", ["from_user_id"], name: "from_user_id", using: :btree
  add_index "join_requests", ["maked_id"], name: "maked_id", using: :btree
  add_index "join_requests", ["maked_type"], name: "maked_type", using: :btree
  add_index "join_requests", ["status"], name: "status", using: :btree
  add_index "join_requests", ["target_id"], name: "target_id", using: :btree
  add_index "join_requests", ["target_type"], name: "target_type", using: :btree
  add_index "join_requests", ["to_org_id"], name: "to_org_id", using: :btree
  add_index "join_requests", ["to_user_id"], name: "to_user_id", using: :btree
  add_index "join_requests", ["type"], name: "type", using: :btree

  create_table "logs", force: true do |t|
    t.boolean  "checked",              default: false, null: false
    t.integer  "kind",       limit: 1, default: 0,     null: false
    t.text     "body"
    t.string   "title"
    t.string   "sub_title"
    t.datetime "created_at"
    t.string   "remote_ip"
  end

  create_table "member_lists", force: true do |t|
    t.integer "module_set_id"
    t.string  "target_type",                   null: false
    t.integer "target_id",                     null: false
    t.boolean "showon_portlet", default: true, null: false
    t.boolean "showon_module",  default: true, null: false
    t.integer "position"
  end

  add_index "member_lists", ["module_set_id"], name: "module_set_id", using: :btree
  add_index "member_lists", ["showon_module"], name: "showon_module", using: :btree
  add_index "member_lists", ["showon_portlet"], name: "showon_portlet", using: :btree
  add_index "member_lists", ["target_id"], name: "target_id", using: :btree
  add_index "member_lists", ["target_type"], name: "target_type", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "from_id",                                null: false
    t.string   "title"
    t.text     "body"
    t.integer  "status",          limit: 1,              null: false
    t.integer  "kind",            limit: 1,              null: false
    t.datetime "created_at"
    t.string   "source_info"
    t.string   "remote_ip",       limit: 15,             null: false
    t.string   "from_type"
    t.integer  "level",           limit: 1,  default: 0
    t.integer  "organization_id"
  end

  add_index "messages", ["created_at"], name: "created_at", using: :btree
  add_index "messages", ["from_id"], name: "with_id", using: :btree
  add_index "messages", ["from_type"], name: "from_type", using: :btree
  add_index "messages", ["kind"], name: "kind", using: :btree
  add_index "messages", ["level"], name: "level_kind", using: :btree
  add_index "messages", ["status"], name: "status", using: :btree
  add_index "messages", ["user_id"], name: "user_id", using: :btree

  create_table "mobile_messages", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.string   "phone",           limit: 20
    t.float    "total_amount",    limit: 24, default: 0.0
    t.float    "cost_amount",     limit: 24, default: 0.0
    t.integer  "send_amount",     limit: 1
    t.integer  "message_id"
    t.integer  "pay_from_org_id"
    t.boolean  "success",                    default: false, null: false
    t.string   "info"
    t.string   "subject"
    t.boolean  "send_by_admin",              default: false, null: false
  end

  add_index "mobile_messages", ["created_at"], name: "created_at", using: :btree
  add_index "mobile_messages", ["message_id"], name: "message_id", using: :btree
  add_index "mobile_messages", ["pay_from_org_id"], name: "pay_from_org_id", using: :btree
  add_index "mobile_messages", ["user_id"], name: "user_id", using: :btree

  create_table "module_sets", force: true do |t|
    t.integer  "organization_id"
    t.integer  "kind",                 limit: 1,    default: 0,            null: false
    t.string   "name"
    t.string   "configure",            limit: 2000, default: "--- {}\n\n", null: false
    t.integer  "parent_id"
    t.integer  "position"
    t.boolean  "hidden",                            default: false,        null: false
    t.integer  "count_content",        limit: 3,    default: 10,           null: false
    t.integer  "theme_kind_content",   limit: 1,    default: 0,            null: false
    t.integer  "display_kind_content", limit: 1,    default: 0,            null: false
    t.integer  "display_column",       limit: 1,    default: 0,            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "new_line",                          default: false,        null: false
    t.integer  "info_id"
  end

  add_index "module_sets", ["display_column"], name: "display_column", using: :btree
  add_index "module_sets", ["hidden"], name: "hidden", using: :btree
  add_index "module_sets", ["organization_id"], name: "organization_id", using: :btree
  add_index "module_sets", ["parent_id"], name: "parent_id", using: :btree

  create_table "new_admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "new_admins", ["email"], name: "index_new_admins_on_email", unique: true, using: :btree
  add_index "new_admins", ["reset_password_token"], name: "index_new_admins_on_reset_password_token", unique: true, using: :btree

  create_table "new_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "name"
    t.string   "image"
    t.integer  "admin_level"
  end

  add_index "new_users", ["reset_password_token"], name: "index_new_users_on_reset_password_token", unique: true, using: :btree

  create_table "order_groups", force: true do |t|
    t.string   "name",                            null: false
    t.string   "descript"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "showon_user",     default: false, null: false
    t.boolean  "showon_personal", default: false, null: false
    t.boolean  "showon_company",  default: false, null: false
    t.boolean  "showon_guild",    default: false, null: false
  end

  add_index "order_groups", ["showon_company"], name: "showon_company", using: :btree
  add_index "order_groups", ["showon_guild"], name: "showon_guild", using: :btree
  add_index "order_groups", ["showon_personal"], name: "showon_personal", using: :btree
  add_index "order_groups", ["showon_user"], name: "showon_user", using: :btree

  create_table "order_plans", force: true do |t|
    t.string   "name"
    t.integer  "kind",           default: 0,     null: false
    t.text     "descript"
    t.text     "configure"
    t.integer  "target_kind",    default: 0
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "month_long",                     null: false
    t.integer  "price",                          null: false
    t.integer  "order_group_id",                 null: false
    t.boolean  "is_hidden",      default: false
  end

  add_index "order_plans", ["is_hidden"], name: "is_hidden", using: :btree
  add_index "order_plans", ["kind"], name: "kind", using: :btree
  add_index "order_plans", ["order_group_id"], name: "order_group_id", using: :btree
  add_index "order_plans", ["target_kind"], name: "target_kind", using: :btree

  create_table "orders", force: true do |t|
    t.string   "owner_type",                          null: false
    t.integer  "owner_id",                            null: false
    t.integer  "price"
    t.boolean  "checked"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_plan_id",                       null: false
    t.string   "serial",                              null: false
    t.integer  "pay_kind",      limit: 1, default: 0, null: false
    t.integer  "pay_type",      limit: 1,             null: false
    t.integer  "kind",          limit: 1, default: 0, null: false
  end

  add_index "orders", ["end_at"], name: "end_at", using: :btree
  add_index "orders", ["order_plan_id"], name: "order_plan_id", using: :btree
  add_index "orders", ["owner_id"], name: "owner_id", using: :btree
  add_index "orders", ["owner_type"], name: "owner_type", using: :btree
  add_index "orders", ["pay_kind"], name: "pay_kind", using: :btree
  add_index "orders", ["pay_type"], name: "pay_type", using: :btree

  create_table "organization_authorizations", force: true do |t|
    t.integer  "user_id",                               null: false
    t.integer  "organization_id"
    t.string   "name"
    t.integer  "main_area",       limit: 2
    t.integer  "sub_area",        limit: 2
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind",            limit: 1, default: 0, null: false
  end

  add_index "organization_authorizations", ["created_at"], name: "created_at", using: :btree
  add_index "organization_authorizations", ["kind"], name: "kind", using: :btree
  add_index "organization_authorizations", ["main_area"], name: "main_area", using: :btree
  add_index "organization_authorizations", ["organization_id"], name: "organization_id", using: :btree
  add_index "organization_authorizations", ["sub_area"], name: "sub_area", using: :btree
  add_index "organization_authorizations", ["user_id"], name: "user_id", using: :btree

  create_table "organization_joint_groups", force: true do |t|
    t.string   "name",                           null: false
    t.text     "descript"
    t.text     "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.boolean  "is_public_joint", default: true, null: false
    t.text     "relation_lft"
  end

  add_index "organization_joint_groups", ["is_public_joint"], name: "is_public_joint", using: :btree
  add_index "organization_joint_groups", ["owner_id"], name: "owner_id", using: :btree

  create_table "organization_joints", force: true do |t|
    t.integer  "organization_joint_group_id", null: false
    t.integer  "organization_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_joints", ["organization_id"], name: "organization_id", using: :btree
  add_index "organization_joints", ["organization_joint_group_id"], name: "organization_joint_group_id", using: :btree

  create_table "organization_members", force: true do |t|
    t.integer  "user_id",                               null: false
    t.integer  "organization_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",           limit: 1, default: 0, null: false
  end

  add_index "organization_members", ["level"], name: "level", using: :btree
  add_index "organization_members", ["organization_id"], name: "organization_id", using: :btree
  add_index "organization_members", ["user_id"], name: "user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "type",                limit: 30,                  null: false
    t.integer  "cover_id"
    t.integer  "use_theme_id"
    t.integer  "main_area",           limit: 1
    t.integer  "sub_area",            limit: 1
    t.string   "name",                                            null: false
    t.integer  "kind",                limit: 1,   default: 0,     null: false
    t.string   "descript"
    t.string   "info"
    t.integer  "display_column",      limit: 1,   default: 0,     null: false
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "fax"
    t.string   "address"
    t.string   "email"
    t.integer  "sms_amount",                      default: 0,     null: false
    t.text     "query"
    t.string   "sms_setting"
    t.datetime "end_at"
    t.integer  "logo_id"
    t.text     "relation_lft"
    t.text     "tree_lft"
    t.boolean  "hide_main_menu"
    t.boolean  "hide_header"
    t.integer  "sort_portlet_column", limit: 1,   default: 0,     null: false
    t.integer  "exhibit",             limit: 1,   default: 0,     null: false
    t.integer  "exhibit_theme",       limit: 1,   default: 0,     null: false
    t.boolean  "show_item_ad",                    default: false, null: false
    t.boolean  "show_ad_on_search",               default: false, null: false
    t.integer  "reg_org_id"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.string   "powered_by",          limit: 400
    t.integer  "depth"
    t.integer  "children_count"
    t.string   "using_style"
  end

  add_index "organizations", ["end_at"], name: "end_at", using: :btree
  add_index "organizations", ["kind"], name: "kind", using: :btree
  add_index "organizations", ["lft"], name: "lft", using: :btree
  add_index "organizations", ["main_area"], name: "main_area", using: :btree
  add_index "organizations", ["parent_id"], name: "parent_id", using: :btree
  add_index "organizations", ["rgt"], name: "rgt", using: :btree
  add_index "organizations", ["sms_amount"], name: "sms_amount", using: :btree
  add_index "organizations", ["sub_area"], name: "sub_area", using: :btree
  add_index "organizations", ["type"], name: "type", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "book_id",                                  null: false
    t.integer  "position",                     default: 0, null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.string   "file_fingerprint",  limit: 32
    t.datetime "created_at"
  end

  add_index "pages", ["book_id"], name: "pages_book_id", using: :btree

  create_table "places", force: true do |t|
    t.string  "name",                               null: false
    t.integer "kind",                               null: false
    t.text    "descript"
    t.string  "img_url"
    t.float   "lng",       limit: 53, default: 0.0, null: false
    t.float   "lat",       limit: 53, default: 0.0, null: false
    t.integer "main_area", limit: 1
    t.integer "sub_area",  limit: 1
    t.integer "top",       limit: 1,  default: 0,   null: false
  end

  add_index "places", ["kind"], name: "kind", using: :btree
  add_index "places", ["lat"], name: "places_lat", using: :btree
  add_index "places", ["lng"], name: "places_lng", using: :btree
  add_index "places", ["main_area"], name: "main_area", using: :btree
  add_index "places", ["sub_area"], name: "sub_area", using: :btree

  create_table "portlet_displays", force: true do |t|
    t.integer "portlet_id"
    t.integer "module_set_id"
    t.integer "kind"
    t.integer "position"
    t.integer "showon",          limit: 1, default: 0, null: false
    t.string  "name"
    t.integer "theme_kind",      limit: 1
    t.integer "display_kind",    limit: 1
    t.integer "show_item_count", limit: 2
    t.integer "organization_id"
  end

  add_index "portlet_displays", ["kind"], name: "kind", using: :btree
  add_index "portlet_displays", ["module_set_id"], name: "module_set_id", using: :btree
  add_index "portlet_displays", ["portlet_id"], name: "portlet_id", using: :btree

  create_table "portlets", force: true do |t|
    t.integer  "organization_id"
    t.integer  "module_set_id"
    t.integer  "kind",            limit: 1,    default: 0,            null: false
    t.string   "name",                                                null: false
    t.string   "configure",       limit: 2000, default: "--- {}\n\n", null: false
    t.integer  "position"
    t.integer  "show_item_count", limit: 2,    default: 5,            null: false
    t.integer  "theme_kind",      limit: 1,    default: 0,            null: false
    t.integer  "display_kind",    limit: 1,    default: 0,            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conf_int"
    t.text     "custom_html"
    t.integer  "adgroup_id"
    t.text     "sqlcache"
    t.string   "ordercache"
  end

  add_index "portlets", ["adgroup_id"], name: "adgroup_id", using: :btree
  add_index "portlets", ["kind"], name: "kind", using: :btree
  add_index "portlets", ["module_set_id"], name: "module_set_id", using: :btree
  add_index "portlets", ["organization_id"], name: "organization_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 30
    t.integer  "user_id"
    t.string   "title"
    t.integer  "emoticons",  limit: 1,  default: 0,     null: false
    t.string   "request_ip", limit: 15,                 null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.boolean  "is_admin",              default: false, null: false
    t.boolean  "report"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "posts", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree
  add_index "posts", ["parent_id"], name: "parent_id", using: :btree
  add_index "posts", ["report"], name: "report", using: :btree
  add_index "posts", ["rgt"], name: "rgt", using: :btree
  add_index "posts", ["user_id"], name: "user_id", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "key", using: :btree

  create_table "sitelog_relations", force: true do |t|
    t.integer  "blog_id",                               null: false
    t.integer  "organization_id",                       null: false
    t.integer  "status",          limit: 1, default: 0, null: false
    t.integer  "check_user_id"
    t.datetime "updated_at"
    t.integer  "from_id"
    t.integer  "kind",            limit: 1, default: 0, null: false
  end

  add_index "sitelog_relations", ["blog_id", "organization_id", "kind"], name: "sitelog_relations_blog_id_organization_id_kind", unique: true, using: :btree
  add_index "sitelog_relations", ["blog_id"], name: "sitelog_relations_blog_id", using: :btree
  add_index "sitelog_relations", ["organization_id", "status"], name: "sitelog_relations_organization_id_is_checked", using: :btree
  add_index "sitelog_relations", ["organization_id"], name: "sitelog_relations_organization_id", using: :btree
  add_index "sitelog_relations", ["status"], name: "sitelog_relations_is_checked", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 30
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 30
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0, null: false
  end

  create_table "temp_article_addons", force: true do |t|
    t.integer   "ShowLeaguer"
    t.integer   "A_Type"
    t.timestamp "SDate",                                       null: false
    t.timestamp "UDate",                                       null: false
    t.string    "Case_No",         limit: 50,                  null: false
    t.string    "FilePath",        limit: 300,                 null: false
    t.text      "Notes"
    t.boolean   "fix_flag",                    default: false, null: false
    t.integer   "temp_article_id"
  end

  create_table "temp_articles", force: true do |t|
    t.timestamp "a_date"
    t.string    "a_city",      limit: 50
    t.string    "a_canton",    limit: 50
    t.string    "a_zip",       limit: 50
    t.string    "case_no",     limit: 50
    t.string    "sale_item",   limit: 50
    t.string    "case_name",   limit: 50
    t.string    "a_type",      limit: 50
    t.integer   "a_year",                                                  default: 0
    t.integer   "a_mom",                                                   default: 0
    t.integer   "a_day",                                                   default: 0
    t.string    "a_con",       limit: 50
    t.string    "tel_con",     limit: 50
    t.string    "tel_con2",    limit: 50
    t.string    "a_own",       limit: 50
    t.string    "addres",      limit: 50
    t.string    "addresnum",   limit: 50
    t.decimal   "a_price",                        precision: 18, scale: 2
    t.string    "a_money",     limit: 50
    t.string    "a_item",      limit: 50
    t.string    "a_floor1",    limit: 50
    t.string    "a_floor3",    limit: 50
    t.string    "a_floor2",    limit: 50
    t.string    "a_site",      limit: 50
    t.string    "a_opinion",   limit: 50
    t.string    "a_route",     limit: 50
    t.string    "a_range",     limit: 50
    t.string    "h_year",      limit: 50
    t.string    "a_land",      limit: 50,                                  default: "0"
    t.string    "main_space",  limit: 50,                                  default: "0"
    t.string    "sub_space",   limit: 50,                                  default: "0"
    t.string    "pos_space",   limit: 50,                                  default: "0"
    t.string    "add_space",   limit: 50,                                  default: "0"
    t.decimal   "total_space",                    precision: 10, scale: 2, default: 0.0
    t.decimal   "s_price",                        precision: 10, scale: 2, default: 0.0
    t.decimal   "l_price",                        precision: 10, scale: 2, default: 0.0
    t.string    "a_style1",    limit: 50
    t.string    "a_style2",    limit: 50
    t.string    "a_style3",    limit: 50
    t.string    "a_stall",     limit: 50
    t.string    "s_school",    limit: 50
    t.string    "m_school",    limit: 50
    t.string    "h_school",    limit: 50
    t.string    "c_school",    limit: 50
    t.string    "a_marker",    limit: 50
    t.string    "a_park",      limit: 50
    t.string    "a_hospital",  limit: 50
    t.string    "a_bank",      limit: 50
    t.string    "s_money",     limit: 50
    t.string    "l_money",     limit: 50
    t.string    "m1_1",        limit: 50
    t.string    "m1_2",        limit: 50
    t.string    "m1_3",        limit: 50
    t.string    "m1_4",        limit: 50
    t.string    "m2_1",        limit: 50
    t.string    "m2_2",        limit: 50
    t.string    "m2_3",        limit: 50
    t.string    "m2_4",        limit: 50
    t.string    "m3_1",        limit: 50
    t.string    "m3_2",        limit: 50
    t.string    "m3_3",        limit: 50
    t.string    "m3_4",        limit: 50
    t.text      "housef"
    t.text      "ffeq"
    t.text      "l_remarks",   limit: 2147483647
    t.text      "l_remarks2"
    t.text      "a_remarks"
    t.text      "remarks1"
    t.text      "remarks2"
    t.text      "remarks3"
    t.text      "remarks4"
    t.text      "remarks5"
    t.string    "a_seat",      limit: 50
    t.string    "outward1",    limit: 200
    t.string    "outward2",    limit: 200
    t.string    "outward3",    limit: 200
    t.string    "outward4",    limit: 200
    t.string    "outward5",    limit: 200
    t.text      "outward6",    limit: 2147483647
    t.text      "outward7"
    t.integer   "a_upload",    limit: 1,                                   default: 0,     null: false
    t.string    "a_hit",       limit: 50
    t.integer   "a_hitted",    limit: 1,                                   default: 0,     null: false
    t.integer   "l_1",                                                     default: 1
    t.string    "l_2",         limit: 50
    t.string    "l_3",         limit: 50,                                  default: "0"
    t.string    "l_4",         limit: 50
    t.string    "l_5",         limit: 50
    t.string    "l_6",         limit: 50
    t.string    "l_7",         limit: 50
    t.string    "l_8",         limit: 50
    t.string    "l_9",         limit: 50,                                  default: "0"
    t.string    "l_a",         limit: 50,                                  default: "0"
    t.string    "l_a2",        limit: 50
    t.string    "l_b",         limit: 50
    t.string    "l_c",         limit: 50
    t.string    "a_url",       limit: 100
    t.datetime  "Udate"
    t.string    "l_d",         limit: 50
    t.string    "KFactoryNo",  limit: 10,                                                  null: false
    t.string    "KCase_No",    limit: 50,                                                  null: false
    t.datetime  "Sdate"
    t.string    "CaseEndDate", limit: 50,                                  default: "0"
    t.string    "StartDate",   limit: 10,                                                  null: false
    t.string    "FinalDate",   limit: 10,                                                  null: false
    t.string    "SetMap",      limit: 50,                                                  null: false
    t.integer   "temp_org_id"
    t.boolean   "fix_flag",                                                default: false, null: false
    t.boolean   "is_maped",                                                default: false
  end

  add_index "temp_articles", ["temp_org_id"], name: "index_factory", using: :btree

  create_table "temp_orgs", force: true do |t|
    t.string  "factory_no",     limit: 50,                 null: false
    t.string  "passwd",         limit: 50,                 null: false
    t.integer "kind",                      default: 0,     null: false
    t.string  "FactoryName",    limit: 50,                 null: false
    t.string  "BossName",       limit: 50,                 null: false
    t.string  "BossTel",        limit: 50,                 null: false
    t.string  "BossFax",        limit: 50,                 null: false
    t.string  "BossMobile",     limit: 50,                 null: false
    t.string  "BossTitle",      limit: 50,                 null: false
    t.string  "CountryNo",      limit: 4,                  null: false
    t.string  "RegionNo",       limit: 4,                  null: false
    t.string  "FactoryAddress", limit: 50,                 null: false
    t.string  "CompanyNo",      limit: 50,                 null: false
    t.boolean "fix_flag",                  default: false, null: false
  end

  add_index "temp_orgs", ["factory_no"], name: "index_factory", unique: true, using: :btree
  add_index "temp_orgs", ["factory_no"], name: "index_factory_no", using: :btree
  add_index "temp_orgs", ["id", "factory_no"], name: "index_id_factory", unique: true, using: :btree

  create_table "themes", force: true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.integer  "cover_id"
    t.string   "name"
    t.text     "body"
    t.integer  "kind",            limit: 1, default: 0,            null: false
    t.text     "descript"
    t.string   "browser_support",           default: "--- []\n\n"
    t.boolean  "is_public",                 default: false,        null: false
    t.boolean  "site",                      default: false,        null: false
    t.string   "version"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "request_site",              default: false,        null: false
  end

  add_index "themes", ["is_public"], name: "is_public", using: :btree
  add_index "themes", ["kind"], name: "kind", using: :btree
  add_index "themes", ["organization_id"], name: "organization_id", using: :btree
  add_index "themes", ["parent_id"], name: "parent_id", using: :btree
  add_index "themes", ["request_site"], name: "request_site", using: :btree
  add_index "themes", ["site"], name: "site", using: :btree
  add_index "themes", ["user_id"], name: "user_id", using: :btree

  create_table "upload_and_folders", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type",        limit: 30
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.integer  "old_id"
    t.string   "temp_key",          limit: 40
    t.boolean  "locked"
    t.integer  "parent_id"
    t.integer  "cover_id"
    t.string   "file_fingerprint",  limit: 32
    t.boolean  "hidden",                       default: false, null: false
  end

  add_index "upload_and_folders", ["hidden"], name: "upload_and_folders_hidden", using: :btree
  add_index "upload_and_folders", ["old_id"], name: "uploads_old_id", using: :btree
  add_index "upload_and_folders", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree
  add_index "upload_and_folders", ["parent_id"], name: "uploads_parent_id", using: :btree
  add_index "upload_and_folders", ["temp_key"], name: "uploads_temp_key", using: :btree
  add_index "upload_and_folders", ["type"], name: "type", using: :btree

  create_table "users", force: true do |t|
    t.integer  "cover_id"
    t.integer  "main_area",                 limit: 1
    t.integer  "sub_area",                  limit: 1
    t.text     "address"
    t.string   "nick_name"
    t.string   "phone"
    t.string   "phone2"
    t.integer  "sex",                       limit: 1
    t.integer  "level",                     limit: 1,   default: 0,            null: false
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "encrypted_password",        limit: 128, default: "",           null: false
    t.string   "password_salt",                         default: "",           null: false
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "info",                      limit: 512, default: "--- {}\n\n"
    t.integer  "old_id"
    t.integer  "sms_amount",                            default: 0,            null: false
    t.string   "sms_setting"
    t.datetime "last_login_at",                                                null: false
    t.integer  "reg_org_id"
    t.boolean  "allow_ad",                              default: false,        null: false
    t.string   "serial"
    t.boolean  "is_normal",                             default: false,        null: false
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "email", using: :btree
  add_index "users", ["level"], name: "level", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["old_id"], name: "users_old_id", using: :btree

  create_table "vote_ips", force: true do |t|
    t.integer "vote_id",               null: false
    t.string  "ip",         limit: 15, null: false
    t.date    "created_at"
  end

  add_index "vote_ips", ["ip"], name: "ip", using: :btree
  add_index "vote_ips", ["vote_id"], name: "vote_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer "owner_id",               null: false
    t.string  "owner_type",             null: false
    t.integer "count",      default: 0, null: false
    t.integer "value",      default: 0, null: false
  end

  add_index "votes", ["owner_id", "owner_type"], name: "owner_id_owner_type", using: :btree

end
