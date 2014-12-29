class AddOrgColumnsForCommissionAndAddLogo < ActiveRecord::Migration
  def self.up
    add_column :organizations , :end_at , :datetime
    add_column :organizations , :logo_id , :integer
  end

  def self.down
    remove_column :organizations , :end_at
    remove_column :organizations , :logo_id
  end
end
