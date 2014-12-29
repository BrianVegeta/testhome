class AddBlogSearchCache < ActiveRecord::Migration
  def self.up
    add_column :blogs , :search_cache , :string
  end

  def self.down
    remove_column :blogs , :search_cache
  end
end
