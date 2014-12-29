class Upload < ActiveRecord::Base ; end
class UploadFolder < ActiveRecord::Base ; end

class MergeUploadAndUploadfolder < ActiveRecord::Migration
  def self.up
    add_column :upload_folders , :temp_id , :integer
    #add_column :uploads , :descript , :string #=> 使用file_content_type
    add_column :uploads , :parent_id , :integer
    add_column :uploads , :flag , :boolean
    add_column :uploads , :cover_id , :integer

    add_index "uploads", ["parent_id"], :name => "uploads_parent_id"

    Upload.update_all("parent_id = upload_folder_id")

    while UploadFolder.count(:conditions => "parent_id IS NULL") != 0
      puts "tern : #{UploadFolder.count} => 0"
      UploadFolder.all(:conditions => "parent_id IS NULL").each do |upload_folder|
        temp = Upload.new(:file_file_name => upload_folder.name , :owner_id => upload_folder.owner_id , :owner_type => upload_folder.owner_type,
          :created_at => upload_folder.created_at , :updated_at => upload_folder.updated_at , :position => upload_folder.position,
          :file_content_type => upload_folder.descript , :parent_id => upload_folder.temp_id , :flag => true ,
          :cover_id => upload_folder.cover_id
        )
        temp.save
        if upload_folder.owner_type == "ModuleSet" #對象為單層目錄，因此不指定對象
          Upload.update_all("parent_id = #{temp.id} , upload_folder_id = NULL" , "upload_folder_id = #{upload_folder.id}") #轉移資料夾物件id
        else
          Upload.update_all("parent_id = #{temp.id} , upload_folder_id = NULL , owner_type = #{upload_folder.owner_type ? "'#{upload_folder.owner_type}'" : "NULL"} , owner_id = #{upload_folder.owner_id ? upload_folder.owner_id : "NULL"}" , "upload_folder_id = #{upload_folder.id}") #轉移資料夾物件id
        end
        UploadFolder.all(:conditions => "parent_id = #{upload_folder.id}").each do |sec_uf|
          sec_uf.update_attributes(:parent_id => nil  , :temp_id => temp.id, :owner_id => upload_folder.owner_id , :owner_type => upload_folder.owner_type)
        end
      end
      UploadFolder.delete_all("parent_id IS NULL")
    end

    drop_table :upload_folders
    Upload.update_all("type = 'UploadFolder'" , "flag = 1") #重新定名
    remove_column :uploads , :flag
    remove_column :uploads , :upload_folder_id
    rename_table :uploads , :upload_and_folders
  end
end