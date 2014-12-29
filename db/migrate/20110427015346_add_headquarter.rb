class Organization < ActiveRecord::Base ; end
class AddHeadquarter < ActiveRecord::Migration
  def self.up
    Organization.update_all("kind = 4" , "type = 'Guild' AND kind = 3") # fix 3 => 4
    create_table "headquarters", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" , :null => false
      t.integer "child_id" , :null => false
    end
    add_index "headquarters", ["organization_id" , "child_id"], :name => "organization_child_id", :unique => true
  end

  def self.down
    drop_table "headquarters"
  end
end
