class AddOrgRelationOrg < ActiveRecord::Migration
  def self.up
    add_column :organizations , :relation_org , :text
    add_column :organization_joint_groups , :relation_org , :text
  end

  def self.down
    remove_column :organizations , :relation_org
    remove_column :organization_joint_groups , :relation_org
  end
end
