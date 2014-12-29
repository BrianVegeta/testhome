class AddAdOrganization < ActiveRecord::Migration
  def self.up
    add_column :ads , :organization_id , :integer
  end

  def self.down
    remove_column :ads , :organization_id
  end
end
