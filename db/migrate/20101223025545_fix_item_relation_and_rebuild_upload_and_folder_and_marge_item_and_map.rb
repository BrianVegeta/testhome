class OrganizationMember < ActiveRecord::Base ; end
class ItemPartake < ActiveRecord::Base ; end

class UploadFolder < ActiveRecord::Base ; end
class Upload < ActiveRecord::Base ; end
class UploadItem < Upload ; end
class UploadVideo < Upload ; end
class UploadFile < Upload ; end

class Map < ActiveRecord::Base ; end
class Item < ActiveRecord::Base ; end
class House < Item ; end
class Land < Item ; end
class FixItemRelationAndRebuildUploadAndFolderAndMargeItemAndMap < ActiveRecord::Migration
  ##修正upload_folder問題
  ##(原)所有upload都有upload_folder_id
  def self.up

    ##修正物件權限
    ##/修正物件權限，如果沒有該組織權限，將該連結刪除
    puts "start_convert_ItemPartake"
    ItemPartake.all.each do |temp|
      temp.destroy unless OrganizationMember.count(:conditions => ["organization_id = ? AND user_id = ? AND level > 0 " , temp.organization_id , temp.user_id]) > 0
    end
    puts "...okay"
    
    ##修正先前資料夾關連錯誤
    UploadFolder.all(:conditions => "owner_type = 'User' AND parent_id IS NOT NULL").each do |user_folder|
      temp_parent = UploadFolder.first(:conditions => "id = #{user_folder.parent_id}")
      if temp_parent && user_folder.owner_type != temp_parent.owner_type #現在為owner => User，parent的owner => Item的情況
        user_folder.update_attributes(:parent_id => nil)
      end
    end
    ##修正先前資料夾關連錯誤

    add_column :uploads , :temp_key , :string , :limit => 40
    add_index "uploads", ["temp_key"], :name => "uploads_temp_key"

    #轉移暫存鍵
    add_column :upload_folders , :is_fixed , :boolean , :default => false , :null => false
    ##轉移temp

    puts "start remove all nouser temp_key"
    UploadFolder.delete_all("temp_key IS NOT NULL AND owner_type IS NULL")
    puts "...okay"

    puts "start rebuild temp folder"
    UploadFolder.all(:select => "id , temp_key , owner_type , owner_id , created_at , updated_at" , :conditions => "temp_key IS NOT NULL").each do |temp_folder|
      #只解一層temp
      UploadFolder.all(:conditions => ["parent_id = ?" , temp_folder.id]).each do |x|
        #解遞迴
        move(temp_folder.id , x.id , temp_folder.owner_type , temp_folder.owner_id)
      end
      Upload.update_all("upload_folder_id = NULL , owner_type = #{temp_folder.owner_type ? "'#{temp_folder.owner_type}'" : 'NULL'} , owner_id = #{temp_folder.owner_id ? "'#{temp_folder.owner_id}'" : 'NULL'} , temp_key = '#{temp_folder.temp_key}' , created_at = DATE('#{temp_folder.created_at}') , updated_at = DATE('#{temp_folder.updated_at}')" , "upload_folder_id = #{temp_folder.id}")
      temp_folder.destroy
    end
    puts "...okay"

    ##修復基本關連(前移)，ModuleSet全系列不修正
    puts "start rebuild normal folder"

## !!!!!!!!!!!!!for test only
#    temp = Item.first(:offset => 3000 , :order => "id DESC");
#    Item.delete_all("id < #{temp.id}");
#    UploadFolder.delete_all("owner_type = 'Item' AND owner_id < #{temp.id}")
## !!!!!!!!!!!!!for test only

    #打掉其餘的所有階層
    total = UploadFolder.count(:conditions => "parent_id IS NULL AND owner_type != 'ModuleSet' AND owner_type != 'User'")
    total.times do |i|
      puts "(#{i}/#{total})" if i % 1000 == 0
      temp_folder = UploadFolder.first(:conditions => ["is_fixed = ? AND parent_id IS NULL AND owner_type != 'ModuleSet' AND owner_type != 'User'" , false])
      break unless temp_folder
      #下層前置
      UploadFolder.all(:conditions => "parent_id = #{temp_folder.id}").each do |temp|
        temp.update_attributes(:is_fixed => 1 , :parent_id => nil , :owner_type => temp_folder.owner_type , :owner_id => temp_folder.owner_id , :temp_key => nil , :created_at => temp_folder.created_at , :updated_at => temp_folder.updated_at)
      end
      Upload.update_all("upload_folder_id = NULL , owner_type = #{temp_folder.owner_type ? "'#{temp_folder.owner_type}'" : 'NULL'} , owner_id = #{temp_folder.owner_id ? temp_folder.owner_id : 'NULL'} , temp_key = NULL , created_at = DATE('#{temp_folder.created_at}') , updated_at = DATE('#{temp_folder.updated_at}')","upload_folder_id = #{temp_folder.id}")
      temp_folder.destroy
    end
    puts "...okay"

    #user打一層掉
    puts "remove User UploadFolder 1 level"
    UploadFolder.all(:conditions => "parent_id IS NULL AND owner_type = 'User'").each do |user_upload_folder|
      Upload.update_all("owner_type = '#{user_upload_folder.owner_type}' , owner_id = #{user_upload_folder.owner_id} , upload_folder_id = NULL" , "upload_folder_id = #{user_upload_folder.id}")
      UploadFolder.update_all("owner_type = '#{user_upload_folder.owner_type}' , owner_id = #{user_upload_folder.owner_id} , parent_id = NULL" , "parent_id = #{user_upload_folder.id}")
      user_upload_folder.destroy
    end
    puts "...okay"
    #user打一層掉

    #子資料夾對象複製(此時應只剩少量的root UploadFolder)
    puts "start copy target link in chile folder"
    UploadFolder.all(:conditions => "parent_id IS NULL").each do |temp_folder|
      fix(temp_folder.owner_id , temp_folder.owner_type , temp_folder.id)
    end
    puts "...okay"

    #之前物件子資料夾轉換(已全打成一層)
    puts "start conver item sub folder"
    UploadFolder.all(:conditions => "owner_type = 'Item'").each do |temp_folder|
      Upload.update_all("owner_type = 'Item' , owner_id = #{temp_folder.owner_id} , upload_folder_id = NULL" , "upload_folder_id = #{temp_folder.id}")
    end
    UploadFolder.delete_all("owner_type = 'Item'")
    puts "...okay"

    remove_column :upload_folders , :is_fixed


    ########maps and item marge
    #items的定位沒有default，來判定是否為nil
    add_column :items , "lng" , :double #必須為double，否則精確度不足
    add_column :items , "lat" , :double #必須為double，否則精確度不足
    add_column :items , "zoom" , :integer  ,       :limit => 1
    add_column :items , "yaw" , :float
    add_column :items , "pitch" , :float
    add_column :items , "auto_find" , :boolean
    add_index "items", ["lat"], :name => "items_lat"
    add_index "items", ["lng"], :name => "items_lng"

    #刪除暫存，因此時暫存的尚無對象
    puts "start marge map"
    Map.delete_all("temp_key IS NOT NULL OR owner_id IS NULL")
    #合併
    ActiveRecord::Base.connection.execute("UPDATE items LEFT JOIN maps ON items.id = maps.owner_id SET items.lng = maps.lng , items.lat = maps.lat , items.zoom = maps.zoom , items.yaw = maps.yaw , items.pitch = maps.pitch , items.auto_find = maps.auto_find")
    puts "...okay"

    #移除map表，實際使用items.lat來做field
    drop_table :maps
  end
  #Folder提至最前
  def self.move(target_id , now_id , target_owner_type , target_owner_id)
    UploadFolder.all(:conditions => ["parent_id = ?",now_id]).each do |x|
      move(target_id , x.id , target_owner_type , target_owner_id)
      Upload.update_all("upload_folder_id = #{target_id} , owner_type = #{target_owner_type ? "'#{target_owner_type}'" : "NULL" } , owner_id = #{target_owner_id ? target_owner_id : "NULL" }" , "upload_folder_id = #{now_id}")
      x.destroy
    end
  end
  #Folder下層全對象指定
  def self.fix(owner_id , owner_type , parent_id)
    UploadFolder.all(:conditions => ["parent_id = ?" , parent_id]).each do |x|
      x.update_attributes(:owner_type => owner_type , :owner_id => owner_id)
      fix(owner_id , owner_type , x.id)
    end
  end
  def self.down
    make_error
  end
end
