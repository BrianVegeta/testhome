class DefaultOrgUrl < ActiveRecord::Migration
  def self.up
    add_column :domains , :is_default , :boolean
  end

  def self.down
    remove_column :domains , :is_default
  end
end