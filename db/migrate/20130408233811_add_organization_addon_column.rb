class AddOrganizationAddonColumn < ActiveRecord::Migration
  def self.up
    add_column :organizations , :meta_description , :string
    add_column :organizations , :meta_keywords , :string
    add_column :organizations , :powered_by , :string , :limit => 400
    add_column :users , :is_normal , :boolean , :default => false , :null => false 
  end
  def self.down
    remove_column :organizations , :meta_descript
    remove_column :organizations , :meta_keyword
    remove_column :organizations , :powered_by
    remove_column :users , :is_normal
  end
end