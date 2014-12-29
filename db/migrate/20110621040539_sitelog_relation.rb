class Sitelog < ActiveRecord::Base ; end
class Blog < ActiveRecord::Base ; end
class SitelogRelation < ActiveRecord::Migration
  def self.up
    add_column :blogs , :level , :integer , :limit => 1 , :default => 0 , :null => false
    
    #merge Sitelog to Blog
    ActiveRecord::Base.connection.execute('
INSERT INTO blogs (type , owner_id , owner_type , title , descript , body , created_at , updated_at , level)
  SELECT "Sitelog" AS type , organization_id AS owner_id , "Organization" AS owner_type , title , descript , body , created_at , updated_at , level FROM sitelogs;
')
    drop_table :sitelogs
    
    #公告P2P修正
    create_table "sitelog_relations", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "blog_id" , :null => false #null => main site
      t.integer "organization_id" , :null => false #null => main site
      t.boolean "is_checked" , :default => false , :null => false
      t.integer "check_user_id"
      t.datetime "updated_at"
    end
    add_index "sitelog_relations", ["blog_id"], :name => "sitelog_relations_blog_id"
    add_index "sitelog_relations", ["organization_id"], :name => "sitelog_relations_organization_id"
    add_index "sitelog_relations", ["is_checked"], :name => "sitelog_relations_is_checked"
    add_index "sitelog_relations", ["organization_id","is_checked"], :name => "sitelog_relations_organization_id_is_checked"
    
    ActiveRecord::Base.connection.execute('
INSERT INTO sitelog_relations (blog_id , organization_id , is_checked , updated_at)
  SELECT id AS blog_id , owner_id AS organization_id , 1 AS is_checked , updated_at FROM blogs WHERE type = "Sitelog";
')
    Blog.update_all("owner_type = NULL , hidden = 1" , "type = 'Sitelog' AND owner_type = 'Organization' AND owner_id IS NULL")
  end

  def self.down
    drop_table "sitelog_relations"
    remove_column :blogs , :level
    
    create_table "sitelogs",:options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.string   "title"
      t.text     "descript"
      t.text     "body"
      t.integer  "level",           :limit => 1, :default => 0, :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "organization_id"
      t.integer  "org_kind",        :limit => 1
    end
    add_index "sitelogs", ["level"], :name => "level"
    add_index "sitelogs", ["org_kind"], :name => "org_kind"
    add_index "sitelogs", ["organization_id"], :name => "organization_id"
  end
end