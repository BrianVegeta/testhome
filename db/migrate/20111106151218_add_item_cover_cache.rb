class Item < ActiveRecord::Base ; end
class AddItemCoverCache < ActiveRecord::Migration
  def self.up
    add_column :items , "has_image" , :boolean , :null => false , :default => false
    Item.update_all("has_image = 1" , "cover_id IS NOT NULL")
  end

  def self.down
    remove_column :items , "has_image"
  end
end
