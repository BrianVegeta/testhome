class AddSitelogForward < ActiveRecord::Migration
  def self.up
    remove_index "sitelog_relations", :name => "sitelog_relations_blog_id_organization_id"
    
    
    add_column :sitelog_relations , :from_id , :integer
    rename_column :sitelog_relations , :kind , :status
    add_column :sitelog_relations , :kind , :integer , :limit => 1 , :default => 0 , :null => false
    
    
    add_index "sitelog_relations", ["blog_id", "organization_id" , "kind"], :name => "sitelog_relations_blog_id_organization_id_kind", :unique => true
  end

  def self.down
    remove_index "sitelog_relations", :name => "sitelog_relations_blog_id_organization_id_kind"
    
    remove_column :sitelog_relations , :kind
    rename_column :sitelog_relations , :status , :kind
    remove_column :sitelog_relations , :from_id
    
    add_index "sitelog_relations", ["blog_id", "organization_id"], :name => "sitelog_relations_blog_id_organization_id", :unique => true
  end
end