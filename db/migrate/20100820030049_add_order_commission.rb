class AddOrderCommission < ActiveRecord::Migration
  def self.up
    create_table "order_commissions" , :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "commission_id" , :null => false
      t.integer  "order_id" , :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "end_at"
    end
    remove_column :commissions , :order_id
    add_column :commissions , :species , :integer , :limit => 1
  end

  def self.down
    drop_table "order_commissions"
    add_column :commissions , :order_id , :integer
    remove_column :commissions , :species
  end
end
