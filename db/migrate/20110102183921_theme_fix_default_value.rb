class ThemeFixDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :themes , "is_public" , :boolean , :default => false , :null => false
  end

  def self.down
    change_column :themes , "is_public" , :boolean , :default => true , :null => false
  end
end
