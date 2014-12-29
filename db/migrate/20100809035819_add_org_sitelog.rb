class AddOrgSitelog < ActiveRecord::Migration
  def self.up
    add_column :sitelogs , :organization_id , :integer
    add_column :sitelogs , :org_kind , :integer , :limit => 1
  end

  def self.down
    remove_column :sitelogs , :organization_id
    remove_column :sitelogs , :org_kind
  end
end
