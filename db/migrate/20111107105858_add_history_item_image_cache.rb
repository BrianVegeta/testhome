class HistoryItem < ActiveRecord::Base ; end
class AddHistoryItemImageCache < ActiveRecord::Migration
  def self.up
    add_column :history_items , "has_image" , :boolean , :null => false , :default => false
    HistoryItem.update_all("has_image = 1" , "cover_id IS NOT NULL")
  end

  def self.down
    remove_column :history_items , "has_image"
  end
end
