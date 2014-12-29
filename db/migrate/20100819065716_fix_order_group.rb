class FixOrderGroup < ActiveRecord::Migration
  def self.up
    create_table "order_groups", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "name" , :null => false
      t.string   "descript"
      t.text     "body" , :limit => 4000
      t.integer  "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end

    drop_table "order_prices"

    add_column "order_plans" , "month_long" , "integer" , :null => false#幾個月
    add_column "order_plans" , "price" , "integer" , :null => false#價格
    add_column "order_plans" , "order_group_id" , "integer" , :null => false #所在群組

    add_column "orders" , "order_plan_id" , "integer" , :null => false
    remove_column "orders" , "name"
    remove_column "orders" , "descript"
    remove_column "orders" , "configure"
    remove_column "orders" , "month_long"
    remove_column "orders" , "kind"
  end
  def self.down
    drop_table "order_groups"

    create_table "order_prices", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "order_plan_id" , :null => false
      t.integer "month_long", :null => false #幾個月
      t.integer "kind" , :null => false , :default => 0 #0 = 預設，1 = 續約??
      t.integer "price" #價格
      t.integer "position"#排序
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end

    remove_column "order_plans" , "month_long"
    remove_column "order_plans" , "price"
    remove_column "order_plans" , "order_group_id"

    remove_column "orders" , "order_plan_id"
    add_column "orders" , "name" , :string
    add_column "orders" , "descript" , :text
    add_column "orders" , "configure" , :text
    add_column "orders" , "month_long" , :integer ,:null => false
    add_column "orders" , "kind" , :integer , :default => 0, :null => false
  end
end

#ALTER TABLE `commissions`  DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci
#ALTER TABLE `order_groups`  DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci
#ALTER TABLE `order_groups` CHANGE `name` `name` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL