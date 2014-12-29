class RemoveOrgIsPublic < ActiveRecord::Migration
  def self.up
    remove_column "organizations" , "is_public"
  end
  def self.down
    add_column "organizations" , "is_public" , :boolean , :default => true , :null => false
  end
end
