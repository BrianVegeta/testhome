class AreaRoad < ActiveRecord::Base ; end
class Area < ActiveRecord::Base ; end
class Item < ActiveRecord::Base ; end
class OrganizationAuthorization < ActiveRecord::Base ; end
class OrganizationRequest < ActiveRecord::Base ; end
class Organization < ActiveRecord::Base ; end
class Place < ActiveRecord::Base ; end
class User < ActiveRecord::Base ; end
class FiveCityConvert < ActiveRecord::Migration
  CLASS_ARRAY = [AreaRoad,Area,Item,OrganizationAuthorization,OrganizationRequest,Organization,Place,User]
  def self.up
    #五都轉換，有使用main_area / sub_area的為
    # # 台北縣[2] => 新北市 => 改區不修正
    #8 => 7 ,+ 8 || 台中縣[8] => 合併台中市[7] => sub{8} + 8
    #14 => 13 , + 6 || 台南縣[15] => 合併台南市[14] => sub{6} + 6
    #15 => 14 , + 13 || 高雄縣[17] => 合併高雄市[16] => sub{13} + 13
    CLASS_ARRAY.each do |target_class|
      #台中
      target_class.update_all("main_area = 7 , sub_area = sub_area + 8" , "main_area = 8")
      target_class.update_all("main_area = main_area - 1" , "main_area > 8")
      #台南
      target_class.update_all("main_area = 13 , sub_area = sub_area + 6" , "main_area = 14")
      target_class.update_all("main_area = main_area - 1" , "main_area > 14")
      #高雄
      target_class.update_all("main_area = 14 , sub_area = sub_area + 13" , "main_area = 15")
      target_class.update_all("main_area = main_area - 1" , "main_area > 15")
    end
  end
  def self.down
    make_error
  end
end
