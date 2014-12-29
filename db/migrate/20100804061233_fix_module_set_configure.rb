class FixModuleSetConfigure < ActiveRecord::Migration
  def self.up
    change_column :module_sets , :configure , :string , :limit => 2000 , :null => false , :default => "--- {}\n\n"
    change_column :portlets , :configure , :string , :limit => 2000 , :null => false , :default => "--- {}\n\n"
  end

  def self.down
    change_column :module_sets , :configure , :text , :default => nil , :null => true
    change_column :portlets , :configure , :text , :default => nil , :null => true
  end
end
