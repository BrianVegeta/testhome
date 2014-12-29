class AddOrderGroupSelectShowOn < ActiveRecord::Migration
  def self.up
    add_column :order_groups , :showon_user , :boolean , :default => false , :null => false
    add_column :order_groups , :showon_personal , :boolean , :default => false , :null => false
    add_column :order_groups , :showon_company , :boolean , :default => false , :null => false
    add_column :order_groups , :showon_guild , :boolean , :default => false , :null => false
  end

  def self.down
    remove_column :order_groups , :showon_user
    remove_column :order_groups , :showon_personal
    remove_column :order_groups , :showon_company
    remove_column :order_groups , :showon_guild
  end
end
