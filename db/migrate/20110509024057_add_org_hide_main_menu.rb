class AddOrgHideMainMenu < ActiveRecord::Migration
  def self.up
    add_column :organizations , :hide_main_menu , :boolean
  end

  def self.down
    remove_column :organizations , :hide_main_menu
  end
end
