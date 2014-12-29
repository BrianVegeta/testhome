require 'active_record/fixtures'
class RebuildSchema < ActiveRecord::Migration
  ##
  ## 此表需與v1的表完全對照，相關修正修改於20100101010102
  ##
  def self.up
    #廣告群組
    create_table "adgroups", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" #null => main site
      t.string  "name", :null => false
      t.integer "width" , :limit => 2
      t.integer "height" , :limit => 2
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "adgroups", ["organization_id"], :name => "adgroup_organization_id"
    #廣告隨機
    create_table "adrands", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "ad_id", :null => false
      t.integer "adgroup_id" #null => banner
      t.integer "organization_id" #null => main site
      t.string  "file_file_name" , :null => false
      t.string  "name" , :null => false
      t.string  "url", :null => false
    end
    add_index "adrands", ["adgroup_id" , "organization_id"], :name => "adrands_adgroup_id_organization_id"
    #廣告
    create_table "ads", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "adgroup_id" #null => banner
      t.string  "name", :null => false
      t.string  "file_file_name"  , :null => false
      t.string  "file_content_type" , :null => false
      t.integer "file_file_size" , :null => false
      t.integer "priority",  :limit => 1, :default => 0, :null => false #最多0~9，需為限制域
      t.string  "url", :null => false
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "ads", ["adgroup_id"], :name => "ad_adgroup_id"
    #地區路名快取表
    create_table "area_roads", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "main_area", :limit => 1 , :null => false #區域
      t.integer "sub_area",  :limit => 1 , :null => false #區域
      t.string  "road" , :null => false #路名
    end
    add_index "area_roads", ["main_area","sub_area"], :name => "main_area_sub_area"
    #地區表，用於區域討論區
    create_table "areas", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string  "name" , :null => false
      t.integer "main_area", :limit => 1 , :null => false
      t.integer "sub_area",  :limit => 1 , :null => false
    end
    add_index "areas", ["main_area","sub_area"], :name => "main_area_sub_area"
    #單篇文章/多篇文章/自訂表單專用表
    create_table "blogs", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "type",       :limit => 30#單表繼承
      t.integer  "owner_id"#隸屬於module_set / item...
      t.string   "owner_type", :limit => 30
      t.integer  "user_id"#著作
      t.integer  "cover_id"#封面
      t.string   "title"#標題
      t.string   "descript"#簡述
      t.text     "body",       :limit => 2147483647 #詳述(自定表單內為meta)
      t.text     "content",    :limit => 2147483647 #自訂表單內容
      t.integer  "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "blogs", ["owner_id","owner_type"], :name => "owner_id_owner_type"
    #網域/連結
    create_table "domains", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_id" , :null => false #對象
      t.string   "name" , :null => false #名稱
      t.integer  "kind",            :limit => 1, :default => 0, :null => false#種類[domain / path]
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "domains", ["name", "kind"], :name => "domain_name_index", :unique => true
    #用於交易提醒，for多人/多公司&隸屬於item_flag
    create_table "item_alerms", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "owner_id",                         :null => false
      t.string   "owner_type",                       :null => false
      t.integer  "item_flag_id",                     :null => false
      t.boolean  "checked",      :default => false , :null => false
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "item_alerms", ["owner_id","owner_type"], :name => "owner_id_owner_type"

    create_table "item_flags", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "user_id"#,                    #使用者
      t.integer "item_id",                     :null => false #物件
      t.integer "kind",                        :null => false #類型 0推/1收/2預約/3分享(log)/4檢舉
      t.string  "title" #標題
      t.text    "body" #內文
      t.boolean "checked",  :default => false , :null => false #檢核
      t.date    "start_at" #開始於
      t.date    "end_at" #結束於
      t.string  "request_ip" , :limit => 15 , :null => false
    end
    add_index "item_flags", ["item_id", "kind"], :name => "item_id_kind"
    add_index "item_flags", ["item_id"], :name => "item_id"
    add_index "item_flags", ["user_id"], :name => "user_id"
      #增加分享物件表，用於公司 => 業務 or 業務 => 的物件分享
      #本身物件 = User || Organization . items (as owner & Organization has lft cache)
      #分享的物件 = User || Organization . item_partakes
      #三表聯集 = 所有的所屬物件
    create_table "item_partakes", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "with_id",                  :null => false
      t.integer  "target_id",                :null => false
      t.integer  "item_id",                  :null => false
      t.string   "with_type",                :null => false
      t.string   "target_type",              :null => false
      t.integer  "kind",        :limit => 1, :null => false
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "item_partakes", ["item_id"], :name => "item_id"
    add_index "item_partakes", ["target_id", "target_type"], :name => "target_id_target_type"
    add_index "item_partakes", ["with_id", "with_type"], :name => "with_id_with_type"
=begin #合併於item_flags
    create_table "item_recommands", :force => true do |t|
      t.integer "user_id", :null => false
      t.integer "item_id", :null => false
    end
    add_index "item_recommands", ["item_id"], :name => "item_id"
=end
    #物件
    create_table "items", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "type",                 :limit => 30#單表繼承[House/Land]
      t.integer  "owner_id",             :null => false#擁有者
      t.string   "owner_type",           :null => false    #變更item為公司 || 業務物件分享，owner為所屬，
      t.integer  "cover_id"#封面
      t.integer  "position"#排序
      t.integer  "sale_kind",            :limit => 1 , :null => false , :default => 0#販賣種類(租/賣/法拍/預售)
      t.integer  "main_area",            :limit => 1 , :null => false#地區
      t.integer  "sub_area",             :limit => 1 , :null => false#地區
      t.string   "name" , :null => false#案名
      t.string   "unique_number"#判別欄位，單純的讓使用者輸入&判別唯一&sort的依據
      t.integer  "emoticons",            :limit => 1#小圖示
      t.boolean  "accessories"  , :default => true , :null => false#配件
      t.integer  "sales_status" , :limit => 1 , :null => false , :default => 0 #物件身分
      t.boolean  "featured",                           :default => false, :null => false#是否精選
      t.string   "road_name"#地址
      t.string   "house_number"#門牌
      t.decimal  "total_price", :precision => 10, :scale => 0 , :default => 0 , :null => false#總價格(租金)(權利金)(拍賣價)
      t.decimal  "per_price", :precision => 10, :scale => 0 , :default => 0 , :null => false#單價(租金單價)
      t.decimal  "addon_price", :precision => 10, :scale => 0 , :default => 0 , :null => false#押金(保證金)
      t.integer  "solds",                :limit => 1 , :null => false , :default => 0#拍次
      t.integer  "direction",            :limit => 1#房屋朝向(東/南/西/北/東北/東南/西北/西南)
      t.integer  "old",                  :limit => 2#屋齡
      t.integer  "upfloor",              :limit => 1#樓高
      t.integer  "downfloor",            :limit => 1#地下樓
      t.text     "floor_select"          #樓層選擇
      t.text     "floor_room_number"     #房間編號選擇
      t.integer  "pattern_room",         :limit => 1 , :null => false , :default => 0#房型(R房L廳B衛)
      t.integer  "pattern_living",       :limit => 1 , :null => false , :default => 0#房型(R房L廳B衛)
      t.integer  "pattern_bath",         :limit => 1 , :null => false , :default => 0#房型(R房L廳B衛)
      t.float    "amount" #總坪數(建物地坪)#自動轉為坪數
      t.float    "public_amount"#公設坪數(建物地坪)#自動轉為坪數
      t.float    "inner_amount"#室內坪數(建物地坪)#自動轉為坪數
      t.float    "addon_amount"#增建坪數(建物地坪)#自動轉為坪數
      t.float    "land_amount"#地坪數(建物地坪)#自動轉為坪數
      t.float    "hold_amount"#持分坪數(建物地坪)#自動轉為坪數
      t.integer  "land_kind" , :null => false , :default => 0#地目
      t.integer  "molecular"#持分比：分子
      t.integer  "denominator"#持分比：分母
      t.boolean  "is_distribution" , :boolean#有無持分
      t.boolean  "boolean"
      t.string   "appearance"#外觀
      t.string   "materials"#建材
      t.string   "wide"#房屋面寬
      t.string   "road_wide"#路寬
      t.string   "house_status"#房屋現況
      t.string   "school"#學區
      t.string   "market"#市場
      t.string   "park"#公園
      t.string   "mrt"#捷運
      t.text     "descript"#補充說明
      t.string   "remarks"#案件備註
      t.string   "parking"#車位
      t.integer  "management_fees"#管理費(數量)
      t.integer  "management_fees_by"#管理費(月,季,半年繳)
      t.datetime "start_at"#上架期間：開始
      t.datetime "end_at" , :null => false , :default => "3000-01-01 00:00:00" #上架期間：結束
      t.boolean  "has_addon" , :null => false , :default => false #法拍，是否點交  土地：有無建物
      t.float    "depth"#深度
      t.integer  "land_bcr"#建蔽率
      t.integer  "land_far"#容積率
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "lft"#父代所屬快取
      t.integer  "recommand_count"#推薦人數
      #是否分享此物件
      #特殊權限 => 新增物件時可選是否分享物件
      #公司物件新增者，建立item_partake，新增者可賣(item_partake KIND新增者)
      #公司特殊權限者，可以進行物件指派(item_partake KIND指派)
      #公司業務，可選分享物件(item_partake KIND抓取)
      t.integer  "share" , :limit => 1 , :default => 0 , :null => false
      t.boolean  "share_sales" , :default => false , :null => false #是否為公開物件分享給公司業務
      t.text     :relation_org #快取org ID用於搜尋
      t.text     :search_cache #搜尋快取項目
      t.string :build_company #建設公司
      t.float "another_amount" #附屬坪
      t.integer "household" , :limit => 1 #總戶數
      t.integer "loan_fees" #現有貸款 / 預估貸款
      t.integer "another_fees" #自備款 / 預估自備款 # 車位租金 (頂讓租金)
      t.datetime "solds_time" #拍期
      t.string "property" , :limit => 70 , :null => false , :default => "--- []\n\n" #
      t.integer "management_way" , :limit => 1
      t.integer "old_id"
      t.boolean "old_map_error"
      t.float "parking_amount"
      t.boolean "old_downloaded" , :default => false
      t.boolean "old_maped" , :default => false
    end
    add_index "items", ["end_at"], :name => "end_at"
    add_index "items", ["end_at"], :name => "items_end_at"
    add_index "items", ["main_area","sub_area"], :name => "main_area_sub_area"
    add_index "items", ["main_area"], :name => "main_area"
    add_index :items , ["old_id"] , :name => "items_old_id"
    add_index "items", ["owner_id","owner_type"], :name => "owner_id_owner_type"
    #歷史紀錄
    create_table "logs", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.boolean  "checked",                              :default => false, :null => false#檢核
      t.integer  "kind",                 :limit => 1,    :default => 0,     :null => false#種類
      t.text     "message"#訊息
      t.string   "exception_message",    :limit => 2000
      t.text     "exception_trace"
      t.text     "log_request"
      t.text     "log_session"
      t.string   "exception_class_name"
      t.string   "controller_name"
      t.string   "action_name"
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    #地圖
    create_table "maps", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "owner_id" #對象
      t.string   "owner_type", :limit => 30
      t.column   "lng", :double , :default => 0.0, :null => false #位置
      t.column   "lat", :double , :default => 0.0, :null => false #位置
      t.integer  "zoom" , :limit => 1 , :default => 0
      t.float    "yaw" , :default => 0.0
      t.float    "pitch" , :default => 0.0
      t.string   "temp_key" #暫存鍵
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.boolean  "auto_find" #是否為系統自動搜尋輸入的
      t.integer  "old_id"
    end

    add_index "maps", ["lat"], :name => "maps_lat"
    add_index "maps", ["lng"], :name => "maps_lng"
    add_index "maps", ["old_id"] , :name => "maps_old_id"
    add_index "maps", ["owner_id","owner_type"], :name => "owner_id_owner_type"

    #站內訊息
    create_table "messages", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "user_id"  #來自(user)(null = side)
      t.integer  "with_id",                 :null => false #對象(user)
      t.string   "title" #標題
      t.text     "body" #內文
      t.integer  "status",     :limit => 1, :null => false #狀態(已讀，未讀...)
      t.integer  "kind",       :limit => 1, :null => false #種類(草稿，垃圾桶，已刪除...)
      t.datetime "created_at"#儲存於
    end
    add_index "messages", ["user_id"], :name => "user_id"
    add_index "messages", ["with_id"], :name => "with_id"
    #功能連結
    create_table "module_sets", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_id" #對象 null = 全站
      t.integer  "permission_kind",      :limit => 1, :default => 0,     :null => false #整體管理等級
      t.boolean  "is_public",                         :default => true,  :null => false #是否公開
      t.integer  "kind",                 :limit => 3, :default => 0,     :null => false #種類
      t.string   "name" #名稱
      t.text     "configure" #設定檔
      t.integer  "parent_id" #tree用
      t.integer  "position"#排序
      t.boolean  "hidden",                            :default => false, :null => false#隱藏於選單
      t.integer  "portlet_index",        :limit => 1#模版位置
      t.integer  "portlet_position",     :limit => 3#模版排序
      t.string   "portlet_title"#模版標題
      t.integer  "count_portlet",        :limit => 3, :default => 5,     :null => false#顯示portlet物件個數
      t.integer  "count_content",        :limit => 3, :default => 10,    :null => false#顯示page時顯示個數
      t.integer  "theme_kind_portlet",   :limit => 1, :default => 0,     :null => false#外觀類型
      t.integer  "theme_kind_content",   :limit => 1, :default => 0,     :null => false
      t.integer  "display_kind_portlet", :limit => 1, :default => 0,     :null => false#顯示類型
      t.integer  "display_kind_content", :limit => 1, :default => 0,     :null => false
      t.text     "display_in"#顯示頁面設定
      t.integer  "display_column",       :limit => 1, :default => 0,     :null => false#顯式內容欄位設定
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "addon_site" , :limit => 1 , :default => nil
      t.integer  "adgroup_id"
    end
    add_index "module_sets", ["organization_id"], :name => "organization_id"
    #使用者註冊時發出業務申請表
    create_table "organization_authorizations", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "user_id" , :null => false #使用者
      t.integer "organization_id" #組織ID
      t.string  "name" #公司名稱 , if null
      t.integer "main_area", :limit => 2#區域
      t.integer "sub_area",  :limit => 2#區域
      t.boolean "checked" #已標註
    end
      #org_group為純管理用，org_joint & org_joint_group用於聯賣，必須先新增org_joint_group才能新增org_joint
      #org_joint_group為org_joint的query cache，任一子org修改lft，org_joint_group就必須連帶修改
    #組織連賣群組
    create_table "organization_joint_groups", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "name"  , :null => false #名稱
      t.text     "descript" #描述
      t.text     "query" #搜尋快取(用於item - lft) #快取，指定聯賣網時使用 # 不cache lft/rgt，只cache query(conditions)
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    #組織連賣關連
    create_table "organization_joints", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_joint_group_id", :null => false #群組ID
      t.integer  "organization_id",             :null => false #組織ID
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    add_index "organization_joints", ["organization_id"], :name => "organization_id"
    add_index "organization_joints", ["organization_joint_group_id"], :name => "organization_joint_group_id"
    #權值
    create_table "organization_member_permissions", :force => true do |t|
      t.integer "organization_member_id" , :null => false
      t.integer "module_set_id" , :null => false
      t.integer "level", :limit => 1 , :default => 0, :null => false
    end
    #組織使用者
    create_table "organization_members", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "user_id" , :null => false#使用者
      t.integer  "organization_id" , :null => false#組織
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "level" , :limit => 1 , :default => 0 , :null => false
    end
    add_index "organization_members", ["organization_id"], :name => "organization_id"
    add_index "organization_members", ["user_id"], :name => "user_id"
    #組織
    create_table "organizations", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "type",           :limit => 30,                    :null => false#型態(Guild/Company/Personal)
      t.integer  "cover_id"#封面
      t.integer  "use_theme_id"#外觀連結
      t.integer  "main_area",      :limit => 1#地區
      t.integer  "sub_area",       :limit => 1
      t.string   "name" , :null => false #名稱
      t.integer  "kind",           :limit => 1#種類
      t.string   "descript"#簡述
      t.string   "info"#詳細
      t.text     "html_header" #上部html [header]
      t.text     "html_footer" #下部html [footer]
      t.integer  "display_column", :limit => 1,  :default => 0,     :null => false #首頁顯示欄位設定
      t.integer  "parent_id" #樹
      t.integer  "position"#排序
      t.integer  "lft"
      t.integer  "rgt"
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.boolean  "is_public" , :default => false , :null => false; #是否關閉Org
      t.string   "phone" #電話
      t.string   "fax" #傳真
      t.string   "address" #地址
      t.string   "email" #mail
      #合法標章，單純的判別，不加入會員公司名稱與編號及結束時間
      t.boolean  "is_licensed",                  :default => false, :null => false #證書
      t.decimal  "sms_amount", :precision => 10, :scale => 0 , :default => 0 , :null => false #簡訊帳戶
      t.text     "query" #快取(item - lft) #反存快取，解決一個org可以參加多個group的問題
    end
    add_index "organizations", ["lft"], :name => "lft"
    #地標
    create_table "places", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string  "name",                      :null => false#名稱
      t.integer "kind",                      :null => false#種類(醫院/學校..)
      t.text    "descript"#描述
      t.string  "img_url"#照片網址
      t.column   "lng", :double , :default => 0.0, :null => false #位置
      t.column   "lat", :double , :default => 0.0, :null => false #位置
      t.integer "main_area" , :limit => 1
      t.integer "sub_area" , :limit => 1
    end
    add_index "places", ["lat"], :name => "places_lat"
    add_index "places", ["lng"], :name => "places_lng"

    #留言板/討論區
    create_table "posts", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "owner_id"#擁有者
      t.string   "owner_type", :limit => 30
      t.integer  "user_id"#使用者
      t.string   "title"#標題
      t.integer  "emoticons",  :limit => 1 , :default => 0 ,    :null => false#表情圖示
      t.string   "request_ip", :limit => 15,                    :null => false#寫入IP
      t.text     "body"#詳細
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "parent_id"
      t.boolean  "is_admin", :default => false , :null => false  #是否管理者回復"等級"
      t.boolean  "report" #是否被列為檢舉
      t.integer  "lft"
      t.integer  "rgt"
    end
    add_index "posts", ["owner_id","owner_type"], :name => "owner_id_owner_type"
    #檢核碼用
    create_table "simple_captcha_data", :options => 'engine=MyISAM default charset=utf8' do |t|
      t.string "key", :limit => 40
      t.string "value", :limit => 6
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    #系統記錄
    create_table "sitelogs", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "title"
      t.text     "descript"
      t.text     "body"
      t.integer  "level" , :limit => 1 , :default => 0 , :null => false;
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    #tag外掛
    create_table "taggings", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "tag_id"
      t.integer  "tagger_id"
      t.string   "tagger_type",   :limit => 30
      t.integer  "taggable_id"
      t.string   "taggable_type", :limit => 30
      t.string   "context"
      t.datetime "created_at"#儲存於
    end

    add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
    add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

    create_table "tags", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string  "name"
      t.integer "taggings_count", :default => 0, :null => false
    end

    #外觀
    create_table "themes", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_id"#隸屬於
      t.integer  "user_id"#使用者
      t.integer  "cover_id"#封面
      t.string   "name"#名稱
      t.text     "body"#內容
      t.integer  "kind",            :limit => 1, :default => 0,            :null => false#種類
      t.text     "descript"#簡述
      t.string   "browser_support",              :default => "--- []\n\n"#支援的瀏覽器
      t.boolean  "is_public",                    :default => true,         :null => false#是否公開
      t.boolean  "site",                :default => false,        :null => false#管理者核定公開
      t.string   "version"#版本
      t.integer  "parent_id"#繼承於
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "depth" , :limit => 1 , :default => 0 , :null => false #深度
      t.boolean  "request_site" #申請審核
    end
    #檔案資料夾 / 檔案上傳
    create_table "upload_folders", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "owner_id"#對象
      t.string   "owner_type", :limit => 30
      t.integer  "parent_id"#繼承/tree
      t.integer  "user_id"#使用者
      t.integer  "cover_id"#封面
      t.string   "name"#名稱
      t.string   "temp_key"#暫存鍵
      t.text     "descript"#描述
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.integer  "position"#排序
      t.integer  "old_id"
      #如果owner為module_set，則upload_folders為檔案下載，所以只增加一個描述用的欄位
      #增加太多欄位會被當成blog用，所以使用純敘述與不允許html
    end
    add_index "upload_folders" , ["old_id"] , :name => "upload_folders_old_id"
    add_index "upload_folders", ["owner_id","owner_type"], :name => "owner_id_owner_type"
    #檔案
    create_table "uploads", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "upload_folder_id"#位於資料夾
      t.integer  "owner_id"#對象
      t.string   "owner_type",        :limit => 30
      t.integer  "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.string   "type"#類型
      t.string   "file_file_name"#迴紋針
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.integer  "old_id"
    end
    add_index "uploads", ["old_id"] , :name => "uploads_old_id"
    add_index "uploads", ["owner_id","owner_type"], :name => "owner_id_owner_type"
    add_index "uploads", ["upload_folder_id"], :name => "upload_folder_id"
    #使用者
    create_table "users", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "cover_id"#選定封面
      t.decimal  "amount",:precision => 10, :scale => 0 , :default => 0 , :null => false #sms帳號
      t.integer  "main_area",                 :limit => 1#地區
      t.integer  "sub_area",                  :limit => 1
      t.text     "address"#住址
      t.string   "nick_name"#暱稱
      t.string   "cell_phone"#手機
      t.string   "phone"#電話1
      t.string   "phone2"#電話2
      t.string   "fax"#傳真
      t.integer  "sex",                       :limit => 1#性別
      t.integer  "level",                     :limit => 1 , :null => false  , :default => 0 #全域管理等級，0一般，1編者，2全站管理員
      t.string   "login",                     :limit => 40#登入帳號
      t.string   "name",                      :limit => 100, :default => ""#名稱
      t.string   "email",                     :limit => 100#E-Mail
      t.string   "crypted_password",          :limit => 40#密碼
      t.string   "salt",                      :limit => 40#檢核
      t.string   "remember_token",            :limit => 40#Cookie
      t.datetime "remember_token_expires_at"
      t.string   "activation_code",           :limit => 40#啟用碼
      t.datetime "activated_at"#啟用於
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      t.boolean  "is_runway",                                :default => false,        :null => false #個人宣傳頁
      t.string   "info",                      :limit => 512, :default => "--- {}\n\n" #多餘欄位(yahoo / msn...)
      t.text     "introduction" #自我介紹
      t.string   "signature" #簽名檔
      t.integer  "old_id"
    end
    add_index "users", ["login"], :name => "index_users_on_login", :unique => true
    add_index "users", ["old_id"] , :name => "users_old_id"
    #投票儲存
    create_table "vote_ips", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "vote_id",                  :null => false
      t.string  "ip",         :limit => 15, :null => false
      t.date    "created_at"#儲存於
    end
    add_index "vote_ips", ["ip"], :name => "ip"
    #投票(1:1)
    create_table "votes", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "owner_id",                  :null => false
      t.string  "owner_type",                :null => false
      t.integer "count",      :default => 0, :null => false
      t.integer "value",      :default => 0, :null => false
    end
    add_index "votes", ["owner_id","owner_type"], :name => "owner_id_owner_type"

    puts "-- Start Load AdministratorUser Fixture"
    temp_time = Time.now
    Fixtures.create_fixtures('test/fixtures', File.basename("users.yml", '.*'))
    puts "   -> " + (Time.now - temp_time).to_f.to_s + "s"

    puts "-- Start Load Place Fixture"
    temp_time = Time.now
    Fixtures.create_fixtures('test/fixtures', File.basename("places.yml", '.*'))
    puts "   -> " + (Time.now - temp_time).to_f.to_s + "s"

    puts "-- Start Load Area Fixture"
    temp_time = Time.now
    Fixtures.create_fixtures('test/fixtures', File.basename("areas.yml", '.*'))
    puts "   -> " + (Time.now - temp_time).to_f.to_s + "s"
    puts "-- Start Load AreaRoad Fixture"
    temp_time = Time.now
=begin
    Fixtures.create_fixtures('test/fixtures', File.basename("area_roads.yml", '.*'))
    puts "   -> " + (Time.now - temp_time).to_f.to_s + "s"
    puts "-- Finish_init"
=end
  end
end