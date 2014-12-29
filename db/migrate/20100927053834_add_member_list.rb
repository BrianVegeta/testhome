class AddMemberList < ActiveRecord::Migration
  def self.up
    create_table "member_lists", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "module_set_id" #null => main site
      t.string  "target_type", :null => false
      t.integer "target_id" , :null => false
      t.boolean "showon_portlet" , :default => true , :null => false
      t.boolean "showon_module" , :default => true , :null => false
      t.integer "position"
    end
  end

  def self.down
    drop_table "member_lists"
  end
end