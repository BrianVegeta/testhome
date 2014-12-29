class AddUploadFolderHidden < ActiveRecord::Migration
  def self.up
    add_column :upload_and_folders , :hidden , :boolean , :default => false , :null => false
    
    add_index :upload_and_folders, ["hidden"], :name => "upload_and_folders_hidden"
    
    add_index "blogs", ["end_at"], :name => "blogs_end_at"
  end

  def self.down
    remove_column :upload_and_folders , :hidden
    remove_index "blogs" , :name => "blogs_end_at"
  end
end
