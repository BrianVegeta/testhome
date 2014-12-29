class AddUserAllowAd < ActiveRecord::Migration
  def self.up
    add_column :users , :allow_ad , :boolean , :default => false , :null => false
  end
  def self.down
    remove_column :users , :allow_ad 
  end
end