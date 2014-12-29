class AddPaperclipFingerprint < ActiveRecord::Migration
  def self.up
    add_column :upload_and_folders , :file_fingerprint , :string , :limit => 32
  end

  def self.down
    remove_column :upload_and_folders , :file_fingerprint
  end
end
