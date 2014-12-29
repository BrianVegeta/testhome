class ItemAddOrgClose < ActiveRecord::Migration
  def self.up
    add_column :items , :is_org_close , :boolean , :default => false , :null => false
  end

  def self.down
    remove_column :items , :is_org_close
  end
end
