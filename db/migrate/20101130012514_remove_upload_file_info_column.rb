class RemoveUploadFileInfoColumn < ActiveRecord::Migration
  def self.up
    remove_column :uploads , :file_info
  end

  def self.down
    add_column :uploads , :file_info , :string
  end
end
