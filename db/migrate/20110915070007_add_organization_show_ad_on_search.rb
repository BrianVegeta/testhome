class AddOrganizationShowAdOnSearch < ActiveRecord::Migration
  def self.up
    add_column :organizations , :show_ad_on_search , :boolean , :default => false , :null => false
  end

  def self.down
    remove_column :organizations , :show_ad_on_search
  end
end
