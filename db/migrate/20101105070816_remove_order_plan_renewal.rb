class RemoveOrderPlanRenewal < ActiveRecord::Migration
  def self.up
    drop_table "order_plan_renewals"
    add_column :orders , :kind , :integer , :limit => 1 , :default => 0 , :null => false
  end

  def self.down
    create_table "order_plan_renewals", :force => true do |t|
      t.integer "order_plan_parent_id" , :null => false
      t.integer "order_plan_id" , :null => false
    end
    remove_column :orders , :kind
  end
end
