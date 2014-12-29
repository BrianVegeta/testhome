class AddBlogIsZombie < ActiveRecord::Migration
  def self.up
    add_column :module_sets , :info_id , :integer
    add_column :blogs , :is_zombie , :boolean , :default => false , :null => false
  end

  def self.down
    remove_column :module_sets , :info_id
    remove_column :blogs , :is_zombie
  end
end
