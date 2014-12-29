class AddOaKind < ActiveRecord::Migration
  def self.up
    add_column :organization_authorizations , :kind , :integer , :limit => 1 , :null => false , :default => 0
  end

  def self.down
    remove_column :organization_authorizations , :kind
  end
end
