class ChengeThemeRequestSite < ActiveRecord::Migration
  def self.up
    change_column :themes , :request_site , :boolean , :default => false , :null => false
  end

  def self.down
    change_column :themes , :request_site , :boolean , :default => nil , :null => true
  end
end
