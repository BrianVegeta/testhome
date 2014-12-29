class AddUserRegOrgId < ActiveRecord::Migration
  def self.up
    add_column :users , :reg_org_id , :integer
    add_column :organizations , :reg_org_id , :integer
  end

  def self.down
    remove_column :users , :reg_org_id
    remove_column :organizations , :reg_org_id
  end
end