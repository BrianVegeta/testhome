class Organization < ActiveRecord::Base
end
class FixOrgPublicLicensedDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :organizations , :is_public , :boolean , :default => true , :null => false
    change_column :organizations , :is_licensed , :boolean , :default => false , :null => false
    Organization.update_all("is_public = 1 , is_licensed = 0")
  end

  def self.down
    change_column :organizations , :is_public , :boolean , :default => nil , :null => true
    change_column :organizations , :is_licensed , :boolean , :default => nil , :null => true
  end
end
