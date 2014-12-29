class AddRequestCompanyForGuild < ActiveRecord::Migration
  def self.up
    #公會審核公司的依據，審核後將直接啟用公司
    create_table "organization_requests", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "organization_id"       ,:null => false #target org_id 申請對象公會的ID
      t.integer  "user_id"               ,:null => false #申請者，將列為管理員
      t.integer  "maked_org_id"                          #已成立的對象的ID
      t.integer  "kind" , :limit => 1,:default => 0,:null => false #狀態

      t.string   "name",                  :null => false #公司名稱
      t.string   "join_name"                             #加盟品牌
      t.string   "master_name",           :null => false #負責人
      t.string   "representative_name",   :null => false #會員代表
      t.string   "capital"               ,:null => false #資本額

      t.integer  "serial_number",         :null => false #會員編號
      t.string   "id_number", :limit => 8,:null => false #統一編號

      t.string   "phone",                 :null => false #電話
      t.string   "fax"                                   #傳真
      t.integer  "main_area", :limit => 1,:null => false #地區
      t.integer  "sub_area",  :limit => 1,:null => false
      t.string   "address",               :null => false #地址

      t.datetime "pay_at"                ,:null => false #營保金繳交日期
      t.datetime "established_at"        ,:null => false #公司成立日期
      t.datetime "join_at"               ,:null => false #入公會日期

      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "end_at"
    end
    remove_column :organizations , "html_header"
    remove_column :organizations , "html_footer"
    remove_column :organizations , "is_licensed" #有被審核通過的一定是licensed
  end

  def self.down
    drop_table :organization_requests
    add_column :organizations , :html_header , :text
    add_column :organizations , :html_footer , :text
    add_column :organizations , "is_licensed" , :boolean , :default => false , :null => false
  end
end