class ItemPartake < ActiveRecord::Base
end
class FixItemPartake < ActiveRecord::Migration
  def self.up
    ItemPartake.delete_all #不可逆
    rename_column :item_partakes , :with_id , :organization_id
    rename_column :item_partakes , :target_id , :user_id

    remove_column :item_partakes , :with_type
    remove_column :item_partakes , :target_type

    add_column :item_partakes , :trans , :integer , :limit => 1 , :default => 0 , :null => false
  end

  def self.down
    rename_column :item_partakes , :organization_id , :with_id
    rename_column :item_partakes , :user_id , :target_id

    add_column :item_partakes , :with_type , :string
    add_column :item_partakes , :target_type , :string

    remove_column :item_partakes , :trans
  end
end
