class CreateOrder < ActiveRecord::Migration
  def self.up
    create_table "order_plans", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string  "name"
      t.integer "kind" , :default => 0 , :null => false #是否為加值服務判定
      t.text    "descript" , :limit => 2000
      t.text    "configure"
      t.integer "target_kind" , :default => 0 #針對的對象(組織)，0 = Company(增加專業/企業公司) , 1 = User(轉Personal)
      t.integer "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    create_table "order_prices", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "order_plan_id" , :null => false
      t.integer "month_long", :null => false #幾個月
      t.integer "kind" , :null => false , :default => 0 #0 = 預設，1 = 續約??
      t.integer "price" #價格
      t.integer "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    create_table "orders", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "name"
      t.text     "descript"
      t.text     "configure"
      t.string   "owner_type" , :null => false
      t.integer  "owner_id" , :null => false
      t.integer  "month_long" , :null => false #幾個月
      t.integer  "kind" , :null => false , :default => 0 #0 = 預設，1 = 續約??
      t.integer  "price"#價格

      t.boolean  "checked" #已讀取
      t.datetime "end_at" #結束於
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end

    create_table "sms_logs", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string  "owner_type"
      t.integer "owner_id"
      t.integer "item_id"
      t.integer "kind" , :limit => 1 , :default => 0 , :null => false
      t.text    "body" , :limit => 2000
      t.datetime "created_at"#儲存於
    end

    create_table "commissions", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "owner_type"
      t.integer  "owner_id"
      t.integer  "item_id"
      t.integer  "kind" , :limit => 1 , :default => 0 , :null => false
      t.integer  "order_id" #最後修改的order的id
      t.datetime "end_at"#結束於
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
    #order必須為Innodb
    add_column :order_plans , :parent_id , :integer
  end

  def self.down
    remove_column :order_plans , :parent_id
    drop_table "order_plans"
    drop_table "order_prices"
    drop_table "orders"
    drop_table "sms_logs"
    drop_table "commissions"
  end
end
