class RenameRelationOrgToRelationLft < ActiveRecord::Migration
  def self.up
    rename_column :items , :relation_org , :relation_lft
    rename_column :organizations , :relation_org , :relation_lft
    rename_column :organization_joint_groups , :relation_org , :relation_lft
  end

  def self.down
    rename_column :items , :relation_lft , :relation_org
    rename_column :organizations , :relation_lft , :relation_org
    rename_column :organization_joint_groups , :relation_lft , :relation_org
  end
end