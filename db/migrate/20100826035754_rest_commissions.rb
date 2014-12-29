class RestCommissions < ActiveRecord::Migration
  def self.up
    drop_table "order_commissions"
    add_column :commissions , :from_id , :integer , :null => false
    add_column :commissions , :from_type , :string , :null => false
    add_column :commissions , :value , :integer , :limit => 1 , :null => false
    change_column :commissions , :species , :integer , :limit => 1 , :null => false , :default => 0
    rename_column :commissions , :species , :main
    add_column :commissions , :sub , :integer , :limit => 1 , :null => false , :default => 0
    remove_column :commissions , :item_id
  end

  def self.down
    create_table "order_commissions" , :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "commission_id" , :null => false
      t.integer  "order_id" , :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "end_at"
    end
    remove_column :commissions , :from_id
    remove_column :commissions , :from_type
    remove_column :commissions , :value
    rename_column :commissions , :main , :species
    change_column :commissions , :species , :integer , :null => true , :default => nil
    remove_column :commissions , :sub
    add_column :commissions , :item_id , :integer
  end
end
