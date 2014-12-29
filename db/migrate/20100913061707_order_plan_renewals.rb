class OrderPlanRenewals < ActiveRecord::Migration
  def self.up
    create_table "order_plan_renewals", :force => true do |t|
      t.integer "order_plan_parent_id" , :null => false
      t.integer "order_plan_id" , :null => false
    end
    add_index "order_plan_renewals", ["order_plan_parent_id" , "order_plan_id"], :name => "order_plan_renewals_relation" , :unique => true
    add_column :order_plans , :is_hidden , :boolean , :default => false
  end

  def self.down
    remove_column :order_plans , :is_hidden
    drop_table :order_plan_renewals
  end
end
