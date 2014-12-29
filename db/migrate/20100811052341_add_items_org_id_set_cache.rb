class AddItemsOrgIdSetCache < ActiveRecord::Migration
  def self.up
    add_column :items , :org_id_set , :text
  end

  def self.down
    remove_column :items , :org_id_set
  end
end
