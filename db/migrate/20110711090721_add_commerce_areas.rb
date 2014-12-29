class AddCommerceAreas < ActiveRecord::Migration
  def self.up
    create_table "commerce_areas", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_id" , :null => false
      t.integer "main_area" , :limit => 1 , :null => false
    end
    add_index "commerce_areas", ["organization_id"], :name => "commerce_areas_organization_id"
    add_index "commerce_areas", ["main_area"], :name => "commerce_areas_main_area"
    add_index "commerce_areas", ["organization_id" , "main_area"], :name => "commerce_areas_organization_id_main_area" , :unique => true
  end

  def self.down
    drop_table "commerce_areas"
  end
end
