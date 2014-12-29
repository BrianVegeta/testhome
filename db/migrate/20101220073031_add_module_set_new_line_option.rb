class AddModuleSetNewLineOption < ActiveRecord::Migration
  def self.up
    add_column :module_sets , :new_line , :boolean , :default => false , :null => false
  end

  def self.down
    remove_column :module_set , :new_line
  end
end