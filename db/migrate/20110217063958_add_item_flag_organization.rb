class AddItemFlagOrganization < ActiveRecord::Migration
  def self.up
    add_column :item_flags , :organization_id , :integer
  end

  def self.down
    remove_column :item_flags , :organization_id
  end
end
