class RemoveOrganizationMemberPermissions < ActiveRecord::Migration
  def self.up
    drop_table "organization_member_permissions"
  end

  def self.down
    create_table "organization_member_permissions", :force => true do |t|
      t.integer "organization_member_id",                             :null => false
      t.integer "module_set_id",                                      :null => false
      t.integer "level",                  :limit => 1, :default => 0, :null => false
    end
  end
end
