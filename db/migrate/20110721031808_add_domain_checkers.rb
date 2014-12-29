class AddDomainCheckers < ActiveRecord::Migration
  def self.up
    create_table "domain_checkers", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "domain_name" , :null => false
      t.string   "punycoded_domain_name" , :null => false
      t.string   "account"
      t.string   "descript"
      t.text     "info"
      
      t.integer  "register_vendors" , :default => 0 ,  :limit => 1 , :null => false
      t.integer  "dns_vendors" , :default => 0 ,  :limit => 1 , :null => false
      
      t.string   "salt" , :null => false
      t.string   "password" , :limit => 512 , :null => false
      
      t.integer  "status" , :limit => 1 , :default => 0 , :null => false
      
      t.date     "record_expired_at" , :null => false
      t.date     "record_created_at" , :null => false
      
      t.datetime "created_at" , :null => false
      t.datetime "scaned_at" , :null => false
    end
    add_index "domain_checkers" , ["record_expired_at"] , :name => "domain_checkers_record_expired_at"
    add_index "domain_checkers" , ["domain_name"] , :name => "domain_checkers_record_expired_at" , :unique => true
  end

  def self.down
    drop_table "domain_checkers"
  end
end
