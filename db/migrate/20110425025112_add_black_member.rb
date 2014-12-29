class AddBlackMember < ActiveRecord::Migration
  def self.up
    create_table "black_members", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" , :null => false #建檔公會
      t.string  "from" #提報單位（提報人）
      t.text    "title" #提報事由
      t.text    "body" #處理狀態
      t.string  "name" #被提報人姓名（黑名單之人）
      t.string  "identity" #身分證字號

      t.integer "main_area" #戶籍地址
      t.integer "sub_area"
      t.string  "address"

      t.string  "sales_id" #營業員証號
      t.string  "agent_id" #經紀人証號

      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.string   "photo_fingerprint",  :limit => 32

      t.datetime "report_at"#提報日期
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
      
      #管理用
      t.integer "user_id" , :null => false #新增帳號
    end
    add_index "black_members", ["identity"], :name => "black_members_identity"
  end

  def self.down
    drop_table :black_members
  end
end


=begin
二˙輸入欄位部份

1. 建檔單位（公會） organization_id
2. 提報單位（提報人）from((string
3. 提報日期 start_at((date
4. 提報事由 title((text
5. 處理狀態 body((text
6. 被提報人姓名（黑名單之人）name((string
7. 身分証號 identity((string
8. 戶籍地址 main_area / sub_area / address((text
9. 營業員証號 sales_id((string
10.經紀人証號 agent_id((string
11.相片 upload
12.created_at date
13.updated_at date

=end