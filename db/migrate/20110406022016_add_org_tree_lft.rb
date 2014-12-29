class AddOrgTreeLft < ActiveRecord::Migration
  def self.up
    add_column :organizations , :tree_lft , :text
  end

  def self.down
    remove_column :organizations , :tree_lft
  end
end
