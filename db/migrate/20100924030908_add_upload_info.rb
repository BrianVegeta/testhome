class AddUploadInfo < ActiveRecord::Migration
  def self.up
    add_column :uploads , :file_info , :string
  end

  def self.down
    remove_column :uploads , :file_info
  end
end
