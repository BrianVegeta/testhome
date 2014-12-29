class Organization < ActiveRecord::Base ; end
class AddCommerce < ActiveRecord::Migration
  def self.up
    #修訂類型：原Guild：["一般公會",0],["全聯會",1],["聯賣網",2],["總公司",3],["其他",4],["其他公會",5]]
    #修正Guild：[["一般公會",0],["全聯會",1],["其他公會",2]
    #修正Commerce[["聯賣網",0],["總公司",1],["其他",2],["其他",3],]
    Organization.update_all("type = 'Commerce' , kind = kind - 2" , "type = 'Guild' AND kind BETWEEN 2 AND 4")
    Organization.update_all("kind = 2" , "type = 'Guild' AND kind = 5")
    Organization.update_all("kind = 3" , "type = 'Commerce' AND kind = 2")
  end

  def self.down
    Organization.update_all("kind = 2" , "type = 'Commerce' AND kind = 3")
    Organization.update_all("kind = 5" , "type = 'Guild' AND kind = 2")
    Organization.update_all("type = 'Guild' , kind = kind + 2" , "type = 'Commerce'")
  end
end